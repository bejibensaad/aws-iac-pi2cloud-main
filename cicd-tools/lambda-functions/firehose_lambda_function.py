import json
import boto3
import base64

output = []

def lambda_handler(event, context):
    print(event)
    for record in event['records']:
        payload = json.loads(base64.b64decode(record['data']).decode('utf-8'))
        print('payload:', payload)
        
        output_payload=""
        for i in payload:
            output_payload=output_payload+str(payload[i])
            output_payload=output_payload+","
            	
        output_payload_clean=output_payload[:-1]+ "\n"
        
        output_payload_postprocessed = base64.b64encode(output_payload_clean.encode('utf-8'))
        
        output_record = {
            'recordId': record['recordId'],
            'result': 'Ok',
            'data': output_payload_postprocessed
        }
        output.append(output_record)

    print('Processed {} records.'.format(len(event['records'])))
    
    return {'records': output}