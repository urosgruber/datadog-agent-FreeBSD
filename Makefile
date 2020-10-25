# $FreeBSD$

PORTNAME=	datadog
DISTVERSIONPREFIX=	${PORTNAME}-
DISTVERSION=	7.16.1
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Datadog Agent

LICENSE=	BSD4CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>0:devel/py-yaml@${PY_FLAVOR}
BUILD_DEPENDS=	go>=1.15:lang/go \
		cmake>=3.18:devel/cmake

USES=		go python:3.7+

DATADOG_PREFIX=	${PREFIX}/bin/${PORTNAME}
LOGDIR=		/var/log/${PORTNAME}

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	datadog-agent
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}
GH_SUBDIR=	src/github.com/DataDog/datadog-agent
GH_TAGNAME=	${DISTVERSION}

# For list of modules you can check:
# https://github.com/DataDog/datadog-agent/blob/${DISTVERSION}/Gopkg.toml
GH_TUPLE=	DataDog:agent-payload:4.24.0:agent_payload/src/github.com/DataDog/agent-payload \
					DataDog:gohai:master:gohai/src/github.com/DataDog/gohai \
					DataDog:zstd:v1.3.0:zstd/src/github.com/DataDog/zstd \
					DataDog:zstd:2b373cb:zstd_v0_5/src/github.com/DataDog/zstd.v0.5 \
					DataDog:integrations-core:7.16.0:integrations \
					hashicorp:consul:v1.0.7:consul/src/github.com/hashicorp/consul \
					beevik:ntp:v0.2.0:ntp/src/github.com/beevik/ntp \
					cihub:seelog:v2.6:seelog/src/github.com/cihub/seelog \
					coreos:etcd:v3.2.23:etcd/src/github.com/coreos/etcd \
					coreos:go-semver:v0.2.0:go_semver/src/github.com/coreos/go-semver \
					moby:moby:v1.13.1:docker/src/github.com/docker/docker \
					containerd:containerd:v1.2.2:containerd/src/github.com/containerd/containerd \
					gogo:protobuf:v1.0.0:protobuf/src/github.com/gogo/protobuf \
					DataDog:mmh3:2cfb684:mmh3/src/github.com/DataDog/mmh3 \
					DataDog:viper:v1.7.0:viper/src/github.com/DataDog/viper \
					aws:aws-sdk-go:v1.12.79:aws_sdk_go/src/github.com/aws/aws-sdk-go \
					clbanning:mxj:v1.8:mxj/src/github.com/clbanning/mxj \
					dustin:go-humanize:9f541cc:go_humanize/src/github.com/dustin/go-humanize \
					fatih:color:v1.7.0:color/src/github.com/fatih/color \
					go-ini:ini:v1.37.0:ini/src/github.com/go-ini/ini \
					gorilla:mux:v1.6.2:mux/src/github.com/gorilla/mux \
					json-iterator:go:v1.1.5:json_iterator/src/github.com/json-iterator/go \
					kardianos:osext:ae77be6:osext/src/github.com/kardianos/osext \
					mholt:archiver:26cf5bb:archiver/src/github.com/mholt/archiver \
					patrickmn:go-cache:v2.1.0:go_cache/src/github.com/patrickmn/go-cache \
					shirou:gopsutil:v2.18.12:gopsutil/src/github.com/shirou/gopsutil \
					dsnet:compress:cc9eb1d:compress/src/github.com/dsnet/compress \
					fsnotify:fsnotify:v1.4.7:fsnotify/src/github.com/fsnotify/fsnotify \
					golang:snappy:2e65f85:snappy/src/github.com/golang/snappy \
					hashicorp:hcl:ef8a98b:hcl/src/github.com/hashicorp/hcl \
					magiconair:properties:v1.8.0:properties/src/github.com/magiconair/properties \
					mitchellh:mapstructure:bb74f1d:mapstructure/src/github.com/mitchellh/mapstructure \
					modern-go:concurrent:1.0.3:concurrent/src/github.com/modern-go/concurrent \
					modern-go:reflect2:1.0.1:reflect2/src/github.com/modern-go/reflect2 \
					nwaples:rardecode:e06696f:rardecode/src/github.com/nwaples/rardecode \
					pelletier:go-toml:v1.2.0:go_toml/src/github.com/pelletier/go-toml \
					pierrec:lz4:v2.0.3:lz4/src/github.com/pierrec/lz4 \
					spf13:afero:v1.1.1:afero/src/github.com/spf13/afero \
					DataDog:cast:1ee8c8b:cast/src/github.com/spf13/cast \
					spf13:cobra:v0.0.3:cobra/src/github.com/spf13/cobra \
					spf13:jwalterweatherman:7c0cea3:jwalterweatherman/src/github.com/spf13/jwalterweatherman \
					spf13:pflag:v1.0.1:pflag/src/github.com/spf13/pflag \
					stretchr:testify:v1.2.2:testify/src/github.com/stretchr/testify \
					ulikunitz:xz:v0.5.4:xz/src/github.com/ulikunitz/xz \
					urfave:negroni:v0.3.0:negroni/src/github.com/urfave/negroni \
					golang:net:97aa3a5:net/src/golang.org/x/net \
					golang:sys:61b9204:sys/src/golang.org/x/sys \
					golang:text:v0.3.0:text/src/golang.org/x/text \
					go-yaml:yaml:v2.2.2:yaml/src/gopkg.in/yaml.v2 \
					kubernetes:apimachinery:def12e6:apimachinery/src/k8s.io/apimachinery \
					coreos:go-systemd:v16:go_systemd/src/github.com/coreos/go-systemd \
					docker:go-connections:v0.3.0:connections/src/github.com/docker/go-connections \
					samuel:go-zookeeper:c4fab1a:go_zookeeper/src/github.com/samuel/go-zookeeper \
					ugorji:go:8c0409f:ugorji_go/src/github.com/ugorji/go \
					coreos:pkg:v4:coreos_pkg/src/github.com/coreos/pkg \
					DataDog:datadog-go:2.1.0:datadog_go/src/github.com/DataDog/datadog-go \
					DataDog:gopsutil:3ca45fa:datadog_gopsutil/src/github.com/DataDog/gopsutil \
					pkg:errors:v0.8.0:errors/src/github.com/pkg/errors \
					tinylib:msgp:v1.1.0:msgp/src/github.com/tinylib/msgp \
					philhofer:fwd:v1.0.0:fwd/src/github.com/philhofer/fwd \
					benesch:cgosymbolizer:bec6fe6:cgosymbolizer/src/github.com/benesch/cgosymbolizer \
					blabber:go-freebsd-sysctl:dcd5a22:go_freebsd_sysctl/src/github.com/blabber/go-freebsd-sysctl
USE_RC_SUBR=	${PORTNAME}-process-agent ${PORTNAME}-trace-agent ${PORTNAME}-agent

GID_FILES=	${PATCHDIR}/GIDs
UID_FILES=	${PATCHDIR}/UIDs

USERS=	dd-agent
GROUPS=	${USERS}

SUB_FILES=	pkg-message
SUB_LIST=	RUNDIR=${RUNDIR} \
		LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD} \
		USER=${USERS} \
		PORTNAME=${PORTNAME} \
		DATADOG_PREFIX=${DATADOG_PREFIX}

PLIST_SUB+=	RUNDIR=${RUNDIR} \
		LOGDIR=${LOGDIR} \
		USER=${USERS} \
		GROUP=${GROUPS} \
		PORTNAME=${PORTNAME} \
		DATADOG_PREFIX=${DATADOG_PREFIX}

OPTIONS_DEFINE=	DOCS APM CONSUL PYTHON EC2 ETCD GCE JMX LOG PROCESS ZK ZLIB
OPTIONS_DEFAULT=	DOCS EC2 GCE LOG PYTHON PROCESS ZLIB

DOCS_DESC=	Install documentation
APM_DESC=	Make the APM agent execution available
CONSUL_DESC=	Enable consul as a configuration store
PYTHON_DESC=	Embed the Python interpreter
EC2_DESC=	Enable EC2 hostname detection and metadata collection
ETCD_DESC=	Enable Etcd as a configuration store
GCE_DESC=	Enable GCE hostname detection and metadata collection
JMX_DESC=	Enable the JMX-fetch bridge
LOG_DESC=	Enable the log agent
PROCESS_DESC=	Enable the process agent
ZK_DESC=	Enable Zookeeper as a configuration store
ZLIB_DESC=	Use zlib

APM_VARS=	agent_build_tags+=apm
CONSUL_VARS=	agent_build_tags+=consul
PYTHON_VARS=	agent_build_tags+=python
EC2_VARS=	agent_build_tags+=ec2
ETCD_VARS=	agent_build_tags+=etcd
GCE_VARS=	agent_build_tags+=gce
JMX_VARS=	agent_build_tags+=jmx
LOG_VARS=	agent_build_tags+=log
PROCESS_VARS=	agent_build_tags+=process
ZK_VARS=	agent_build_tags+=zk
ZLIB_VARS=	agent_build_tags+=zlib

USE_LDCONFIG=	yes

PYTHON_BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}invoke>=1.2.0_1:devel/py-invoke \
			${PYTHON_PKGNAMEPREFIX}reno>=2.9.2:textproc/py-reno \
			${PYTHON_PKGNAMEPREFIX}docker>=3.0.1:sysutils/py-docker \
			${PYTHON_PKGNAMEPREFIX}yaml>=5.1:devel/py-yaml \
			${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
			${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
			${PYTHON_PKGNAMEPREFIX}requests>=2.21.0:www/py-requests \
			${PYTHON_PKGNAMEPREFIX}toml>=0.9.4:textproc/py-toml

LD_FLAG_STRING=		-s -X '${GO_PKGNAME}/pkg/version.AgentVersion=${DISTVERSION}'

DATADOG_BINARIES=	agent dogstatsd process-agent trace-agent

# find integrations-core -name setup.py | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
INTEGRATIONS=	active_directory activemq activemq_xml aerospike amazon_msk ambari apache aspdotnet btrfs cacti cassandra cassandra_nodetool ceph cilium cisco_aci clickhouse cockroachdb consul coredns couch couchbase crio datadog_checks_base datadog_checks_downloader datadog_checks_tests_helper directory disk dns_check docker_daemon dotnetclr druid ecs_fargate elastic envoy etcd exchange_server external_dns fluentd gearmand gitlab gitlab_runner go_expvar go-metro gunicorn haproxy harbor hdfs_datanode hdfs_namenode hive http_check hyperv ibm_db2 ibm_mq ibm_was iis istio jboss_wildfly kafka kafka_consumer kong kube_apiserver_metrics kube_controller_manager kube_dns kube_metrics_server kube_proxy kube_scheduler kubelet kubernetes kubernetes_state kyototycoon lighttpd linkerd linux_proc_extras mapr mapreduce marathon mcache mesos_master mesos_slave mongo mysql nagios network nfsstat nginx nginx_ingress_controller openldap openmetrics openstack openstack_controller oracle pdh_check pgbouncer php_fpm postfix postgres powerdns_recursor presto process prometheus rabbitmq redisdb riak riakcs sap_hana snmp solr spark sqlserver squid ssh_check statsd supervisord system_core system_swap tcp_check teamcity tls tokumx tomcat twemproxy twistlock varnish vault vertica vsphere win32_event_log windows_service wmi_check yarn zk

# find integrations-core -name conf.yaml.example | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
CONFFILES=	active_directory activemq activemq_xml aerospike amazon_msk ambari apache aspdotnet btrfs cacti cassandra cassandra_nodetool ceph cilium cisco_aci clickhouse cockroachdb consul coredns couch couchbase crio directory dns_check docker_daemon dotnetclr druid ecs_fargate elastic envoy etcd exchange_server external_dns fluentd gearmand gitlab gitlab_runner go_expvar go-metro gunicorn haproxy harbor hdfs_datanode hdfs_namenode hive http_check hyperv ibm_db2 ibm_mq ibm_was iis istio jboss_wildfly kafka kafka_consumer kong kube_apiserver_metrics kube_controller_manager kube_dns kube_metrics_server kube_proxy kube_scheduler kubelet kubernetes kubernetes_state kyototycoon lighttpd linkerd linux_proc_extras mapr mapreduce marathon mcache mesos_master mesos_slave mongo mysql nagios nfsstat nginx nginx_ingress_controller openldap openmetrics openstack openstack_controller oracle pdh_check pgbouncer php_fpm postfix postgres powerdns_recursor presto process prometheus rabbitmq redisdb riak riakcs sap_hana snmp solr spark sqlserver squid ssh_check statsd supervisord system_core system_swap tcp_check teamcity tls tokumx tomcat twemproxy twistlock varnish vault vertica vsphere win32_event_log windows_service wmi_check yarn zk

#post-extract:
#	@${MKDIR} ${WRKSRC}/vendor/github.com/vishvananda
#	@${RLN} ${WRKSRC_mdlayher_netlink} ${WRKSRC}/vendor/github.com/vishvananda/netlink

do-build:
# Build rtloader (Previously called six)
	(cd ${WRKSRC}/rtloader && ${SETENV} ${MAKE_ENV} ${BUILD_ENV} \
		cmake -DBUILD_DEMO:BOOL=OFF \
		-DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
		-DDISABLE_PYTHON2=ON && make -C .)

# Build go binaries
.for bin in ${DATADOG_BINARIES}
	(cd ${GO_WRKSRC}/cmd/${bin}; \
		${SETENV} ${MAKE_ENV} ${BUILD_ENV} GOPATH=${WRKSRC} \
		CGO_CFLAGS="-w -I${WRKSRC}/rtloader/include -I${WRKSRC}/rtloader/common" \
		CGO_LDFLAGS="-L${WRKSRC}/rtloader/rtloader" go build -tags \
		'${AGENT_BUILD_TAGS}' -o ${GO_WRKSRC}/cmd/${bin}/${bin} -ldflags "${LD_FLAG_STRING}")
.endfor

# Generate config files
	go run ${GO_WRKSRC}/pkg/config/render_config.go agent-py3 \
	${GO_WRKSRC}/pkg/config/config_template.yaml \
	${GO_WRKSRC}/cmd/agent/dist/datadog.yaml

do-install:
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}
	${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
	${MKDIR} ${STAGEDIR}${LOGDIR}
	${MKDIR} ${STAGEDIR}${DOCSDIR}
	${MKDIR} ${STAGEDIR}${RUNDIR}

.for doc in README.md CHANGELOG.rst CONTRIBUTING.md LICENSE
	(${INSTALL_MAN} ${WRKSRC}/${doc} ${STAGEDIR}${DOCSDIR})
.endfor

	# Install binaries
	#${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/process-agent/process-agent ${STAGEDIR}${DATADOG_PREFIX}/process-agent
	#${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/trace-agent/trace-agent ${STAGEDIR}${DATADOG_PREFIX}/trace-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/agent/agent	${STAGEDIR}${DATADOG_PREFIX}/agent
	cd ${GO_WRKSRC}/cmd/agent && ${COPYTREE_SHARE} dist ${STAGEDIR}${DATADOG_PREFIX}
	cd ${GO_WRKSRC}/pkg/status/dist && ${COPYTREE_SHARE} templates ${STAGEDIR}${DATADOG_PREFIX}/dist

	# Install core-integrations
.for dir in ${CONFFILES}
	(cd ${WRKSRC_integrations}/${dir}; \
	${MV} datadog_checks/${dir}/data ${STAGEDIR}${ETCDIR}/conf.d/${dir}.d)
.endfor

.for dir in ${INTEGRATIONS}
	(cd ${WRKSRC_integrations}/${dir}; \
	${PYTHON_CMD} setup.py bdist; \
	${TAR} -xzf dist/*.tar.gz -C ${STAGEDIR})
.endfor

	# Install rtloader library
	cd ${WRKSRC}/rtloader && make -C . ${INSTALL} DESTDIR=${STAGEDIR}

	# Install configuration files
	${INSTALL_DATA} ${GO_WRKSRC}/cmd/agent/dist/datadog.yaml \
		${STAGEDIR}${ETCDIR}/datadog.yaml.example
	${SED} -ie 's/^# confd_path\: ""/confd_path: "\/usr\/local\/etc\/datadog\/conf.d"/g' \
		${STAGEDIR}${ETCDIR}/datadog.yaml.example

post-install:
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libdatadog-agent-rtloader.so.0.1.0
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libdatadog-agent-three.so

.include <bsd.port.mk>
