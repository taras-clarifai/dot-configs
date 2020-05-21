# see below; called by _psql_credstash_alias
function _alias_lookup() {
   alias_name=$1
   alias_command=$2

   # cause bash to evaluate $alias_command when creating the new alias:
   alias ${alias_name}="$alias_command"
   # use the alias for the first time:
   eval $alias_name
}

function _psql_credstash_alias() {
    alias_name=$1
    credstash_value=$2
    eval "alias ${alias_name}='_alias_lookup \"${alias_name}\" \"psql \\\"\$(credstash get ${credstash_value})\\\"\"'"
    #eval "alias ${alias_name}+='_alias_lookup \"${alias_name}+\" \"pgcli \\\"\$(credstash get ${credstash_value})\\\"\"'"
}

# rw postgres
_psql_credstash_alias "psql_dev_rw" "go/src/clarifai/api:dev:databaseURL"
_psql_credstash_alias "psql_staging_rw" "go/src/clarifai/api:staging:databaseURL"
_psql_credstash_alias "psql_prod_rw" "go/src/clarifai/api:prod:databaseURL"

# read only postgres
_psql_credstash_alias "psql_dev" "go/src/clarifai/api:dev:databaseURLRead"
_psql_credstash_alias "psql_staging" "go/src/clarifai/api:staging:databaseURLRead"
_psql_credstash_alias "psql_prod" "go/src/clarifai/api:prod:databaseURLRead"

alias psql_local='psql -h 127.0.0.1 -p 5432 -U clarifai api_local'
alias psql_test='psql -h 127.0.0.1 -p 5432 -U clarifai api_test'

alias k='kubectl'
# API
alias api-init='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_run.sh'
alias api-quick='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_run.sh -ipnd'
alias api-debug='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_run.sh -ipndb'
alias api-debug-listen='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_debug-api.sh -r'
alias api-check='api-host && API_CHECK_URL="http://$(api-host)/v2/healthz" && echo "Calling $API_CHECK_URL ..." && curl $API_CHECK_URL| jq .'
alias api-forward='api-host && echo "Forwarding port 32674 to $(api-host)..." && socat TCP-LISTEN:32674,fork TCP:$(api-host)'
api-host() {
	API_IP=$(api-ip);
	if [ -z $API_IP ]; then
		echo "IP error";
		return 1;
	fi;
	API_PORT=$(api-port);
	if [ -z $API_PORT ]; then
		echo "Port error";
		return 1;
	fi;
	echo "$API_IP:$API_PORT";
}
alias api-ip-public='ifconfig ens4 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]* | sed "s/inet //"'
alias api-ip='api-pod >> /dev/null && l describe $(api-pod) | grep Node: | grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"'
alias api-pod='l get pods -o name | grep clarifai'
alias api-port='l get svc | grep go-src-clarifai-scripts | grep -Po "8000:.*?/TCP" | sed s/8000://g | sed s#/TCP##g'
# Postgress
alias postgres-pod='l get pod -o name | grep postgres'
alias postgres-ip='l get svc | grep postgres | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"'
alias postgres-port='l get svc | grep postgres | grep -o "[0-9]*/TCP" | sed s#/TCP##'
postgres-host() {
	POSTGRES_IP=$(postgres-ip);
	if [ -z $POSTGRES_IP ]; then
		echo "IP error";
		return 1;
	fi;
	POSTGRES_PORT=$(postgres-port);
	if [ -z $POSTGRES_PORT ]; then
		echo "Port error";
		return 1;
	fi;
	echo "$POSTGRES_IP:$POSTGRES_PORT";
}
alias postgres-forward='postgres-host && echo "Forwarding port 30000 to $(postgres-host)..." && socat TCP-LISTEN:30000,fork TCP:$(postgres-host)'
# Test Api
alias test-api-init='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_test.sh'
alias test-api-quick='$CLARIFAI_ROOT/go/src/clarifai/scripts/k8s_test.sh -pdnci'

alias build-proto="$CLARIFAI_ROOT/proto/run_proto_build.sh"
