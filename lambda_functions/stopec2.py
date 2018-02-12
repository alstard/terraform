import boto3
import sys

region = 'eu-west-2'

def lambda_handler(event, context):
    # Suspend Launch process in any ASG groups Owned by atd
    asg_client = boto3.client('autoscaling')
    asg_paginator = asg_client.get_paginator('describe_auto_scaling_groups')
    asg_page_iterator = asg_paginator.paginate(PaginationConfig={'PageSize': 100})
    atd_asgs = asg_page_iterator.search('AutoScalingGroups[] | [?contains(Tags[?Key==`{}`].Value, `{}`)]'.format('Owner', 'atd'))
    ProcessesToSuspend = ['Launch']

    for asg in atd_asgs:
        print 'INFO: Suspending Launch Process for ASG: ' + asg['AutoScalingGroupName']
        asg_client.suspend_processes(AutoScalingGroupName=asg['AutoScalingGroupName'], ScalingProcesses=ProcessesToSuspend)

    # Get the Running ec2 instance ids
    ec2resource = boto3.resource('ec2', region_name=region)
    is_mybox_running_filter = [{'Name': 'instance-state-name', 'Values': ['running']}, {'Name': 'tag:Owner', 'Values': ['atd']}]
    running_instances = ec2resource.instances.filter(Filters=is_mybox_running_filter)
    ec2ids = []
    for instance in running_instances:
        ec2ids.append(instance.id)

    # Shutdown any instances
    if not ec2ids:
        print 'INFO: You have no instances to stop.'
    else:
        ec2client = boto3.client('ec2', region_name=region)
        ec2client.stop_instances(InstanceIds=ec2ids)
        print 'INFO: stopped the following instance ids: ' + str(ec2ids)

# Unit Test
if __name__ == "__main__":

    region = 'eu-west-2'
    lambda_handler("test_event", "test_context")
