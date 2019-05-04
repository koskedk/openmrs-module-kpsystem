/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.kpsystem;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Level;
import org.apache.log4j.LogManager;
import org.openmrs.api.context.Context;
import org.openmrs.module.ModuleActivator;
import org.openmrs.module.kpcore.CoreContext;
import org.openmrs.module.reporting.report.service.ReportService;

/**
 * This class contains the logic that is run every time this module is either started or stopped.
 */
public class EmrActivator implements ModuleActivator {

	protected static final Log log = LogFactory.getLog(EmrActivator.class);

	static {
		// Possibly bad practice but we really want to see these startup log messages
		LogManager.getLogger("org.openmrs.module.kpcore").setLevel(Level.INFO);
		LogManager.getLogger("org.openmrs.module.kpsystem").setLevel(Level.INFO);
	}

	/**
	 * @see ModuleActivator#willRefreshContext()
	 */
	public void willRefreshContext() {
		log.info("KPSystem context refreshing...");
	}

	/**
	 * @see ModuleActivator#willStart()
	 */
	public void willStart() {
		log.info("KPSystem starting...");
	}

	/**
	 * @see ModuleActivator#contextRefreshed()
	 */
	public void contextRefreshed() {
		Configuration.configure();

		try {
			CoreContext.getInstance().refresh();
		}
		catch (Exception ex) {
			// If an error occurs during core refresh, we need KPSystem to still start so that the error can be
			// communicated to an admin user. So we catch exceptions, log them and alert super users.
			log.error("Unable to refresh core context", ex);

			// TODO re-enable once someone fixes TRUNK-4267
			//Context.getAlertService().notifySuperUsers("Unable to start KPSystem", ex);
		}
	}

	/**
	 * @see ModuleActivator#started()
	 */
	public void started() {
		Context.getService(ReportService.class).deleteOldReportRequests();
		log.info("KPSystem started");
	}

	/**
	 * @see ModuleActivator#willStop()
	 */
	public void willStop() {
		log.info("KPSystem stopping...");
	}

	/**
	 * @see ModuleActivator#stopped()
	 */
	public void stopped() {
		log.info("KPSystem stopped");
	}
}