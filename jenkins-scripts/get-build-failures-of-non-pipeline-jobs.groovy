import jenkins.model.*

// Only useful if you're using the Build Failure plugin in Jenkins!

def bfaPlugin = com.sonyericsson.jenkins.plugins.bfa.PluginImpl.getInstance()
def knowledgeBase = bfaPlugin.getKnowledgeBase()

void printFailureCausesOfJob(hudson.model.FreeStyleProject someJob) {
	def actionsOfSomeJob = someJob.getAllActions()
	for (def someAction in actionsOfSomeJob) {
	  	if (someAction instanceof com.sonyericsson.jenkins.plugins.bfa.model.FailureCauseProjectAction) {
        		def failureCauseProjectAction = someAction
			def failureCauseBuildAction = failureCauseProjectAction.getAction()
			if (failureCauseBuildAction != null) {
				for (failureCause in failureCauseBuildAction.getFoundFailureCauses()) {
					println("job: " + someJob.getName() + ", name: " + failureCause.getName() + ", description: " + failureCause.getDescription())
				}
			}
		}
  	}
}

for (item in Jenkins.instance.items) {
	if (item instanceof org.jenkinsci.plugins.workflow.job.WorkflowJob) {
		// ignore: only non-pipeline jobs
	} else {
		printFailureCausesOfJob(item)
	}
}
