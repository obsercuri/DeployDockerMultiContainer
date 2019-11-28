#!/bin/bash

#Definition of variables
subscription="<subscripionname>"
resourceGrp="<resourcegroupname>"
appServicePlan="<app-service-plan-name>"
AppServiceName="<app-service-name>"

az account set --subscription $subscription

#Create a Resource Group to structure your resource deployments
az group create --name $resourceGrp --location "West Europe"

#Create an app Service plan to deploy your containers in
#takes up to 3min
az appservice plan create --name $appServicePlan --resource-group $resourceGrp --sku S1 --is-linux

#Deploys an webapplicaiton app with multi container
#Will take up to 10min 
az webapp create --resource-group $resourceGrp --plan $appServicePlan --name $AppServiceName --multicontainer-config-type compose --multicontainer-config-file docker-compose.yml

#Configure local Storage
az webapp config appsettings set --resource-group $resourceGrp --name $AppServiceName --settings WEBSITES_ENABLE_APP_SERVICE_STORAGE=TRUE

#If necessary configure logging
#az webapp log config --name d-app-hftmmulticontainer --resource-group d-reg-hftmmulticontainer --docker-container-logging filesystem
#az webapp log tail --name d-app-hftmmulticontainer --resource-group d-reg-hftmmulticontainer

echo http://$AppServiceName.azurewebsites.net
