# **Simple NodeJs Terraform Ansible App**

## **Setup**

### Google Cloud

You will have to activate some APIs: 
- Compute Engine
- Cloud Storage

Create a storage bucket then edit `bucket` with the bucket name in `tfstate.tf`:
- You can use this link : https://console.cloud.google.com/storage/ to create manually a storage bucket
- You can create it automatically using `gsutil`: 

```
gsutil mb \                    
-c regional \        
-l europe-west1 \
gs://terraform-state-$(date|md5sum|awk '{print $1}')
```


### Local environment

Download your service account credentials in `./gce-account.json` from https://console.cloud.google.com/apis/credentials/serviceaccountkey

You will need to install `apache-libcloud` :

```
pip install apache-libcloud
```

If you want to update gce.py and gce.ini with current version you will need to clone the ansible project and fetch those two files

```
git clone https://github.com/ansible/ansible ansible-project
cp ansible-project/contrib/inventory/gce.py ./ansible/inventory/
cp ansible-project/contrib/inventory/gce.ini ./ansible/
```

Configure `./ansible/gce.ini` file with these fields: 

```
gce_service_account_email_address = # Service account email found in service account json
gce_service_account_pem_file_path = # Path to ansible service account json
gce_project_id = # GCE project name
```

Then **export gce.ini environment variable** or run `source setup.sh`

```
export GCE_INI_PATH=$(realpath ./ansible/gce.ini)
```