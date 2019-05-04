/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.kpsystem.visit;

import org.junit.Before;
import org.junit.Test;
import org.openmrs.Patient;
import org.openmrs.VisitType;
import org.openmrs.module.kpcore.form.FormManager;
import org.openmrs.module.kpcore.test.TestUtils;
import org.openmrs.module.kpsystem.metadata.CommonMetadata;
import org.openmrs.module.kpsystem.metadata.KpMetadata;
import org.openmrs.module.metadatadeploy.MetadataUtils;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Tests for {@link EmrVisitAssignmentHandler}. Most of the functionality provided by this class is actually tested in
 * {@link org.openmrs.module.kpsystem.integration.FormsAndVisitsTest}
 */
public class EmrVisitAssignmentHandlerTest extends BaseModuleContextSensitiveTest {

	@Autowired
	private CommonMetadata commonMetadata;

	@Autowired
	private KpMetadata kpMetadata;


	@Autowired
	private FormManager formManager;

	/**
	 * Setup each test
	 */
	@Before
	public void setup() throws Exception {
		executeDataSet("dataset/test-concepts.xml");

		commonMetadata.install();
		kpMetadata.install();
		formManager.refresh();
	}

	/**
	 * @see EmrVisitAssignmentHandler#getAutoCreateVisitType(org.openmrs.Encounter)
	 */
	@Test
	public void getAutoCreateVisitType_shouldReturnAutoCreateVisitTypeIfSpecified() {
		VisitType outpatient = MetadataUtils.existing(VisitType.class, CommonMetadata._VisitType.OUTPATIENT);

		// Check form that doesn't specify one
		/*Encounter hivAddendum = new Encounter();
		hivAddendum.setForm(MetadataUtils.existing(Form.class, KpMetadata._Form.CLINICAL_ENCOUNTER_HIV_ADDENDUM));

		Assert.assertThat(EmrVisitAssignmentHandler.getAutoCreateVisitType(hivAddendum), is(nullValue()));

		// Check form that does specify one
		Encounter moh257 = new Encounter();
		moh257.setForm(MetadataUtils.existing(Form.class, KpMetadata._Form.MOH_257_VISIT_SUMMARY));

		Assert.assertThat(EmrVisitAssignmentHandler.getAutoCreateVisitType(moh257), is(outpatient));*/
	}

	/**
	 * @see EmrVisitAssignmentHandler#checkLocations(org.openmrs.Visit, org.openmrs.Encounter)
	 */
	@Test
	public void checkLocations() {
		Patient patient = TestUtils.getPatient(7);
		//Form moh257 = MetadataUtils.existing(Form.class, KpMetadata._Form.MOH_257_VISIT_SUMMARY);
		VisitType outpatient = MetadataUtils.existing(VisitType.class, CommonMetadata._VisitType.OUTPATIENT);

		/*// Save regular visit on Jan 1st at no specific location
		Visit visit0 = TestUtils.saveVisit(patient, outpatient, TestUtils.date(2012, 1, 1), null);

		// Save regular visit on Jan 1st at location #2
		Visit visit1 = TestUtils.saveVisit(patient, outpatient, TestUtils.date(2012, 1, 1), null);
		visit1.setLocation(Context.getLocationService().getLocation(1));

		// Save regular visit on Jan 1st at location #2
		Visit visit2 = TestUtils.saveVisit(patient, outpatient, TestUtils.date(2012, 1, 1), null);
		visit2.setLocation(Context.getLocationService().getLocation(2));

		// Save MOH257 for that day (will default to location #1)
		Encounter encounter = TestUtils.saveEncounter(patient, moh257, TestUtils.date(2012, 1, 1));

		Assert.assertThat(EmrVisitAssignmentHandler.checkLocations(visit0, encounter), is(true));
		Assert.assertThat(EmrVisitAssignmentHandler.checkLocations(visit1, encounter), is(true));
		Assert.assertThat(EmrVisitAssignmentHandler.checkLocations(visit2, encounter), is(false));*/
	}
}