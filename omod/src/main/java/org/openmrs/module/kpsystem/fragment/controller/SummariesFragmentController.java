/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.kpsystem.fragment.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.kpsystem.api.KenyaEmrService;
import org.openmrs.module.kpsystem.calculation.library.models.PatientSummary;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.fragment.FragmentModel;

/**
 * Created by codehub on 10/30/15.
 * A fragment controller for a patient summary details
 */
public class SummariesFragmentController {
    protected static final Log log = LogFactory.getLog(SummariesFragmentController.class);

    public void controller(@FragmentParam("patient") Patient patient,
                           FragmentModel model){
        PatientSummary patientSummary = new PatientSummary();
        PatientService patientService = Context.getPatientService();
        KenyaEmrService kenyaEmrService = Context.getService(KenyaEmrService.class);

        model.addAttribute("patient", patientSummary);

        }



}
