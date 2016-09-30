import jenkins.model.*

for (item in Jenkins.instance.items) {
	println("job $item.name")
}
