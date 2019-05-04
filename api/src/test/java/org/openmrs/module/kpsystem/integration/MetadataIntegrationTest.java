/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.kpsystem.integration;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.api.context.Context;
import org.openmrs.module.kpcore.form.FormManager;
import org.openmrs.module.kpcore.identifier.IdentifierManager;
import org.openmrs.module.kpcore.program.ProgramManager;
import org.openmrs.module.kpcore.test.TestUtils;
import org.openmrs.module.kpsystem.metadata.CommonMetadata;
import org.openmrs.module.kpsystem.metadata.KpMetadata;
import org.openmrs.module.kpsystem.metadata.SecurityMetadata;
import org.openmrs.module.metadatadeploy.bundle.MetadataBundle;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.openmrs.test.SkipBaseSetup;
import org.openmrs.util.OpenmrsConstants;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Tests for importing of KenyaEMR metadata packages
 */
public class MetadataIntegrationTest extends BaseModuleContextSensitiveTest {

	protected static final Log log = LogFactory.getLog(MetadataIntegrationTest.class);

	@Autowired
	private SecurityMetadata securityMetadata;

	@Autowired
	private CommonMetadata commonMetadata;

	@Autowired
	private KpMetadata kpMetadata;

	@Autowired
	private IdentifierManager identifierManager;

	@Autowired
	private ProgramManager programManager;

	@Autowired
	private FormManager formManager;

	@Before
	public void setup() throws Exception {
		initializeInMemoryDatabase();
		executeDataSet("dataset/test-minimal.xml");
		executeDataSet("dataset/test-concepts.xml");
		authenticate();

		// Required to run these tests from an IDE as values in OpenmrsConstants won't have been set correctly
		if (OpenmrsConstants.OPENMRS_VERSION.startsWith("Sun")) {
			TestUtils.modifyConstant(OpenmrsConstants.class, "OPENMRS_VERSION", "1.9.3  Build f535e9");
			TestUtils.modifyConstant(OpenmrsConstants.class, "OPENMRS_VERSION_SHORT", "1.9.3.f535e9");
		}
	}

	/**
	 * Tests...
	 */
	@Test
	@SkipBaseSetup
	public void loadAllMetadataProvidersAndRefreshManagers() throws Exception {
		installBundleWithFlush(securityMetadata);
		installBundleWithFlush(commonMetadata);
		installBundleWithFlush(kpMetadata);

		// Easiest way to check that we're not missing any identifiers, programs, forms or encounter types
		identifierManager.refresh();
		programManager.refresh();
		formManager.refresh();

		// And then load them again to simulate startup on an up-to-date database
		installBundleWithFlush(securityMetadata);
		installBundleWithFlush(commonMetadata);
		installBundleWithFlush(kpMetadata);
	}

	protected void installBundleWithFlush(MetadataBundle bundle) throws Exception {
		bundle.install();

		Context.flushSession();
	}
}