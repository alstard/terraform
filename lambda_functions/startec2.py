import boto3

region = 'eu-west-2'

def lambda_handler(event, context):
    ec2resource = boto3.resource('ec2', region_name=region)
    stopped_atd_instances_filter = [{ 'Name': 'instance-state-name', 'Values': ['stopped']}, {'Name': 'tag:Name', 'Values': ['atd-*']}]
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
