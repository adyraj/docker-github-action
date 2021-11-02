import sys
def handler(event, context):
    return 'Hello from AWS Lambda from Python' + sys.version + '!'        