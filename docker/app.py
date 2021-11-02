import sys
def handler(event, context):
    return 'Hello from AWS Lambda Python' + sys.version + '!'        