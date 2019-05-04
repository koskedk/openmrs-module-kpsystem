/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.kpsystem.page.controller.dialog;

import org.openmrs.Cohort;
import org.openmrs.Patient;
import org.openmrs.PatientIdentifier;
import org.openmrs.PatientIdentifierType;
import org.openmrs.api.context.Context;
import org.openmrs.calculation.patient.PatientCalculationContext;
import org.openmrs.calculation.patient.PatientCalculationService;
import org.openmrs.module.kpcore.CoreUtils;
import org.openmrs.module.kpcore.report.ReportDescriptor;
import org.openmrs.module.kpcore.report.ReportManager;
import org.openmrs.module.kpsystem.api.impl.CsvMaker;
import org.openmrs.module.kpsystem.metadata.CommonMetadata;
import org.openmrs.module.kpsystem.metadata.KpMetadata;
import org.openmrs.module.kpui.KenyaUiUtils;
import org.openmrs.module.kpui.annotation.SharedPage;
import org.openmrs.module.metadatadeploy.MetadataUtils;
import org.openmrs.module.reporting.dataset.DataSetColumn;
import org.openmrs.module.reporting.dataset.MapDataSet;
import org.openmrs.module.reporting.indicator.dimension.CohortIndicatorAndDimensionResult;
import org.openmrs.module.reporting.report.ReportData;
import org.openmrs.module.reporting.report.ReportRequest;
import org.openmrs.module.reporting.report.definition.ReportDefinition;
import org.openmrs.module.reporting.report.service.ReportService;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.FileDownload;
import org.openmrs.ui.framework.page.PageRequest;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Controller for cohort dialog
 */
@SharedPage
public class CohortDownloadPageController {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

    public FileDownload controller
            (
                    @RequestParam("request") ReportRequest reportRequest,
                    @RequestParam("dataset") String dataSetName,
                    @RequestParam("column") String columnName,
                    PageRequest pageRequest,
                    @SpringBean ReportManager reportManager,
                    @SpringBean KenyaUiUtils kenyaUi,
                    @SpringBean ReportService reportService,
                    @SpringBean CsvMaker csvMaker
            ) {
        ReportDefinition definition = reportRequest.getReportDefinition().getParameterizable();
        ReportDescriptor report = reportManager.getReportDescriptor(definition);

        CoreUtils.checkAccess(report, kenyaUi.getCurrentApp(pageRequest));

        ReportData reportData = reportService.loadReportData(reportRequest);

        MapDataSet dataSet = (MapDataSet) reportData.getDataSets().get(dataSetName);

        DataSetColumn dataSetColumn = dataSet.getMetaData().getColumn(columnName);
        Object result = dataSet.getData(dataSetColumn);

        Cohort cohort = null;
        if (result instanceof CohortIndicatorAndDimensionResult) {
            CohortIndicatorAndDimensionResult cidr = (CohortIndicatorAndDimensionResult) dataSet.getData(dataSetColumn);
            cohort = cidr.getCohortIndicatorAndDimensionCohort();
        } else if (result instanceof Cohort) {
            cohort = (Cohort) result;
        }

        List<Patient> patients = Context.getPatientSetService().getPatients(cohort.getMemberIds());

        PatientCalculationService calculationService = Context.getService(PatientCalculationService.class);
        PatientCalculationContext calculationContext = calculationService.createCalculationContext();
        Date endDate = (Date) reportRequest.getReportDefinition().getParameterMappings().get("endDate");
        calculationContext.setNow(endDate);

        /*DateOfEnrollmentArtCalculation dateOfEnrollmentArtCalculation = new DateOfEnrollmentArtCalculation();
        CalculationResultMap enrollmentDates = dateOfEnrollmentArtCalculation.evaluate(cohort.getMemberIds(), null, calculationContext);

        InitialArtStartDateCalculation initialArtStartDateCalculation = new InitialArtStartDateCalculation();
        CalculationResultMap artInitializationDates = initialArtStartDateCalculation.evaluate(cohort.getMemberIds(), null, calculationContext);
*/

        List<Object> data = new ArrayList<Object>();
        List<Object> headerRow = new ArrayList<Object>();
        List<Object> header = new ArrayList<Object>();
        header.add("Name");
        header.add("Age");
        header.add("Gender");
        header.add("UPN/Patient Clinic Number");
        header.add("Enrollment Date");
        header.add("ART Initiation Date");
        headerRow.add(header.toArray());
        for (Patient patient : patients) {
            List<Object> row = new ArrayList<Object>();
            row.add(patient.getPersonName().getFullName());
            row.add(patient.getAge());
            row.add(patient.getGender());
            row.add(getUpn(patient));

            /*String enrollmentDate = null;
            CalculationResult enrollmentDateCalcResult = enrollmentDates.get(patient.getId());
            if (enrollmentDateCalcResult != null && enrollmentDateCalcResult.getValue() != null) {
                enrollmentDate = DATE_FORMAT.format((Date) enrollmentDateCalcResult.getValue());
            }
            row.add(enrollmentDate);*/

            /*String artInitializationDate = null;
            CalculationResult artInitializationDateCalcResult = artInitializationDates.get(patient.getId());
            if (artInitializationDateCalcResult != null && artInitializationDateCalcResult.getValue() != null) {
                artInitializationDate = DATE_FORMAT.format((Date) artInitializationDateCalcResult.getValue());
            }
            row.add(artInitializationDate);

            data.add(row.toArray());*/
        }
        String filename =  "Cohort.csv";
        FileDownload fileDownload = new FileDownload(filename, "text/csv", csvMaker.createCsv(data, header));
        return fileDownload;
    }

    private PatientIdentifier getUpn(Patient patient) {
        PatientIdentifierType clinicNoIdType = MetadataUtils.existing(PatientIdentifierType.class, CommonMetadata._PatientIdentifierType.PATIENT_CLINIC_NUMBER);
        PatientIdentifierType upnIdType = MetadataUtils.existing(PatientIdentifierType.class, KpMetadata._PatientIdentifierType.UNIQUE_PATIENT_NUMBER);

        for (PatientIdentifier patientIdentifier : patient.getIdentifiers()) {
            if (patientIdentifier.getIdentifierType().equals(upnIdType)) {
                return patientIdentifier;
            }
        }

        for (PatientIdentifier patientIdentifier : patient.getIdentifiers()) {
            if (patientIdentifier.getIdentifierType().equals(clinicNoIdType)) {
                return patientIdentifier;
            }
        }
            return null;
        }
}