import boto3

region = 'eu-west-2'

def lambda_handler(event, context):
    ec2resource = boto3.resource('ec2', region_name=region)
    is_mybox_running_filter = [{'Name': 'instance-state-name', 'Values': ['running']}, {'Name': 'tag:Name', 'Values': ['atd-*']}]
    running_instances = ec2resource.instances.filter(Filters=is_mybox_running_filter)

    ec2ids = []
    for instance in running_instances:
        ec2ids.append(instance.id)

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
