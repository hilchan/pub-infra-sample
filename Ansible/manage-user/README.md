How to Run?

To run this playbook, you need to have permission to root user
-> sudo -l
Test with Ansible 2.3.2.0  ("pip install -I ansible==2.3.2.0" if needed)

If you need to enter your password to switch yourself to root user, then use the below
-> ansible-playbook playbook.yml --extra-vars "host=<environment>" --ask-sudo-pass
	- <environment> - will be dev/qa/staging/prod/demo which you can find it from the hosts file

If you do not need to enter your password to do sudo, run the below
-> ansible-playbook playbook.yml --extra-vars "host=<environment>"
        - <environment> - will be dev/qa/staging/prod/demo which you can find it from the hosts file

Example:
-> ansible-playbook add-user-devops.yml --extra-vars "host=ondemand" --extra-vars "userlist=user_list_devops_active" -u ec2-user  (Used on blank instance without Devops users)
