import boto3

region = 'eu-west-2'

def lambda_handler(event, context):
    # Resume Launch process in any ASG groups Owned by atd
    asg_client = boto3.client('autoscaling')
    asg_paginator = asg_client.get_paginator('describe_auto_scaling_groups')
    asg_page_iterator = asg_paginator.paginate(PaginationConfig={'PageSize': 100})
    atd_asgs = asg_page_iterator.search('AutoScalingGroups[] | [?contains(Tags[?Key==`{}`].Value, `{}`)]'.format('Owner', 'atd'))
    ProcessesToResume = ['Launch']

    for asg in atd_asgs:
        print 'INFO: Resuming Launch Process for ASG: ' + asg['AutoScalingGroupName']
        asg_client.resume_processes(AutoScalingGroupName=asg['AutoScalingGroupName'], ScalingProcesses=ProcessesToResume)

    # We will explicitly startup all ec2 instances
    ec2resource = boto3.resource('ec2', region_name=region)
    stopped_atd_instances_filter = [{ 'Name': 'instance-state-name', 'Values': ['stopped']}, {'Name': 'tag:Owner', 'Values': ['atd']}]
    stopped_instances = ec2resource.instances.filter(Filters=stopped_atd_instances_filter)

    ec2iids = []
    for instance in stopped_instances:
        ec2iids.append(instance.id)
    
    if not ec2iids:
        print 'INFO: You have no instances to start-up'
    else:
        ec2client = boto3.client('ec2', region_name=region)
        ec2client.start_instances(InstanceIds=ec2iids)
        print 'INFO: Started the following instances ids: ' + str(ec2iids)

# Unit Test
if __name__ == "__main__":
    lambda_handler("test_event", "test_context")
