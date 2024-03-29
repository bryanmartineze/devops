#add a server to an ansible inventory
cat > inventory.txt
node01 ansible_host=ansible-target01.swo.com ansible_ssh_common_args='-o ForwardAgent=yes'
node02 ansible_host=ansible-target02.swo.com ansible_ssh_common_args='-o ForwardAgent=yes'

[target_group]
target01
target02

#make a basic ping test with ansible
ansible node01 -m ping -i inventory.txt


#Create a keys.yml file and put inside the AWS credentials

cat > keys.yml

AWS_ACCESS_KEY_ID:
AWS_SECRET_ACCESS_KEY:
AWS_REGION: us-east-1

#encrypt the keys.yml with ansible-vault encryption

ansible-encrypt keys.yml

#Create a test.yml playbook

- name: Test gather info from instance named demo
  hosts: localhost
  gather_facts: yes
  become: true
  vars_files:
    - keys.yml
  tasks:
    - name: Chenge instances state by tag
    