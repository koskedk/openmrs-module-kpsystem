/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */

package org.openmrs.module.kenyaemr.fragment.controller.program.mch;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.PatientProgram;
import org.openmrs.module.kenyaemr.Dictionary;
import org.openmrs.module.kenyaemr.util.EmrUtils;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.fragment.FragmentModel;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * MCH program enrollment fragment
 */
public class MchEnrollmentSummaryFragmentController {

	public String controller(@FragmentParam("patientProgram") PatientProgram enrollment,
							 @FragmentParam(value = "encounter", required = false) Encounter encounter,
							 @FragmentParam("showClinicalData") boolean showClinicalData,
							 FragmentModel model) {

		Map<String, Object> dataPoints = new LinkedHashMap<String, Object>();
		dataPoints.put("Enrolled", enrollment.getDateEnrolled());

		Obs ancNoObs = EmrUtils.firstObsInProgram(enrollment, Dictionary.getConcept(Dictionary.ANTENATAL_CASE_NUMBER));
		if (ancNoObs != null) {
			dataPoints.put("ANC No. ", ancNoObs.getValueNumeric());
		}
		Obs lmpObs = EmrUtils.firstObsInProgram(enrollment, Dictionary.getConcept("1427AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"));
		Date edd;
		if (lmpObs != null) {
			edd = calculateEdd(lmpObs.getValueDate());
			if (edd == null) {
				dataPoints.put("EDD: ", "Unknown (Missing L.M.P.)");
			} else {
				dataPoints.put("EDD: ", edd);
			}
		}
		model.put("dataPoints", dataPoints);
		return "view/dataPoints";
	}

	private Date calculateEdd(Date lmp) {
		Date edd = null;
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(lmp);
		int lmpDay = calendar.get(Calendar.DAY_OF_MONTH);
		int lmpMonth = calendar.get(Calendar.MONTH);
		int lmpYear = calendar.get(Calendar.YEAR);

		int dayOffset = 7;
		int monthOffset = -2;
		int yearOffset = 1;

		int eddDay = lmpDay + dayOffset;
		int dim = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		if (eddDay > dim) {
			eddDay -= dim;
			monthOffset++;
		}
		int eddMonth = lmpMonth + monthOffset;
		if (eddMonth <= 0) {
			eddMonth += 12;
			yearOffset--;
		}
		int eddYear = lmpYear + yearOffset;
		try {
			String eddDateString = (eddDay <= 9 ? "0" + eddDay : eddDay) + "-" + (eddMonth <= 9 ? "0" + eddMonth : eddMonth) + "-" + eddYear;
			edd = new SimpleDateFormat("dd-MM-yyyy").parse(eddDateString);
		} catch (ParseException pe) {
			System.out.println(pe.getMessage());
		}
		return edd;
	}
}