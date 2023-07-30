MODULE="NewsapiNetworking/Sources/NewsapiNetworking/"

openapi-generator generate -i "newsapi.yml" -g swift5 -o "newsapi"
rm -r $MODULE""*
cp -R "newsapi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "newsapi"
