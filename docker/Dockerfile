FROM public.ecr.aws/lambda/python:3.8

# Copy function code
COPY docker/app.py ${LAMBDA_TASK_ROOT}

# Install the function's dependencies using file requirements.txt
# from your project folder.

COPY docker/requirements.txt  .

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]