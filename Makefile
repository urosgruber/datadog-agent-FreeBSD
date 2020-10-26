# $FreeBSD$

PORTNAME=	datadog
DISTVERSIONPREFIX=	${PORTNAME}-
DISTVERSION=	7.17.1
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Datadog Agent

LICENSE=	BSD4CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>0:devel/py-yaml@${PY_FLAVOR}
BUILD_DEPENDS=	go>=1.15:lang/go \
		cmake>=3.18:devel/cmake

USES=		go:modules python:3.7+

DATADOG_PREFIX=	${PREFIX}/bin/${PORTNAME}
LOGDIR=		/var/log/${PORTNAME}
RUNDIR=		/var/run/${PORTNAME}

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	datadog-agent
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}
GH_SUBDIR=	src/github.com/DataDog/datadog-agent
GH_TAGNAME=	${DISTVERSION}

# For list of modules you can check:
# https://github.com/DataDog/datadog-agent/blob/${DISTVERSION}/Gopkg.toml
GH_TUPLE=	DataDog:agent-payload:4.19.0:datadog_agent_payload/src/github.com/DataDog/agent-payload \
		DataDog:cast:1ee8c8b:datadog_cast/src/github.com/spf13/cast \
		DataDog:datadog-go:2.2.0:datadog_datadog_go/src/github.com/DataDog/datadog-go \
		DataDog:gohai:107ebc5:datadog_gohai/src/github.com/DataDog/gohai \
		DataDog:gopsutil:833e93e:datadog_gopsutil/src/github.com/DataDog/gopsutil \
		DataDog:integrations-core:7.17.1:integrations \
		DataDog:mmh3:6574a42:datadog_mmh3/src/github.com/DataDog/mmh3 \
		DataDog:viper:v1.7.0:datadog_viper/src/github.com/DataDog/viper \
		DataDog:watermarkpodautoscaler:ad62a4a:datadog_watermarkpodautoscaler/src/github.com/DataDog/watermarkpodautoscaler \
		DataDog:zstd:2b373cb:datadog_zstd/src/github.com/DataDog/zstd \
		DataDog:zstd:v1.3.8:datadog_zstd_13/src/github.com/DataDog/zstd.v1.3 \
		aws:aws-sdk-go:v1.12.79:aws_aws_sdk_go/src/github.com/aws/aws-sdk-go \
		beevik:ntp:v0.2.0:beevik_ntp/src/github.com/beevik/ntp \
		benesch:cgosymbolizer:bec6fe6:benesch_cgosymbolizer/src/github.com/benesch/cgosymbolizer \
		beorn7:perks:v1.0.1:beorn7_perks/src/github.com/beorn7/perks \
		blabber:go-freebsd-sysctl:dcd5a22:blabber_go_freebsd_sysctl/src/github.com/blabber/go-freebsd-sysctl \
		cenkalti:backoff:v3.0.0:cenkalti_backoff/src/github.com/cenkalti/backoff \
		cihub:seelog:v2.6:cihub_seelog/src/github.com/cihub/seelog \
		clbanning:mxj:v1.8.4:clbanning_mxj/src/github.com/clbanning/mxj \
		containerd:cgroups:fc51bcb:containerd_cgroups/src/github.com/containerd/cgroups \
		containerd:containerd:v1.2.9:containerd_containerd/src/github.com/containerd/containerd \
		coreos:etcd:v3.2.23:coreos_etcd/src/github.com/coreos/etcd \
		coreos:go-semver:v0.2.0:coreos_go_semver/src/github.com/coreos/go-semver \
		coreos:go-systemd:v16:coreos_go_systemd/src/github.com/coreos/go-systemd \
		coreos:pkg:v4:coreos_pkg/src/github.com/coreos/pkg \
		docker:go-connections:v0.4.0:docker_go_connections/src/github.com/docker/go-connections \
		dsnet:compress:v0.0.1:dsnet_compress/src/github.com/dsnet/compress \
		dustin:go-humanize:v1.0.0:dustin_go_humanize/src/github.com/dustin/go-humanize \
		fatih:color:v1.7.0:fatih_color/src/github.com/fatih/color \
		emicklei:go-restful:v2.10.0:emicklei_go_restfu/src/github.com/emicklei/go-restful \
		emicklei:go-restful-swagger12:1.0.1:emicklei_go_restful_swagger12/src/github.com/emicklei/go-restful-swagger12 \
		evanphx:json-patch:v4.5.0:evanphx_json_patch/src/github.com/evanphx/json-patch \
		fatih:color:v1.7.0:fatih_color/src/github.com/fatih/color \
		florianl:go-conntrack:06743d3:florianl_go_conntrack/src/github.com/florianl/go-conntrack \
		fsnotify:fsnotify:v1.4.7:fsnotify_fsnotify/src/github.com/fsnotify/fsnotify \
		go-ini:ini:v1.46.0:go_ini_ini/src/github.com/go-ini/ini \
		go-yaml:yaml:v2.2.2:go_yaml_yaml/src/gopkg.in/yaml.v2 \
		gogo:protobuf:v1.3.0:gogo_protobuf/src/github.com/gogo/protobuf \
		golang:net:24e19bd:golang_net/src/golang.org/x/net \
		golang:protobuf:v1.3.2:golang_protobuf/src/github.com/golang/protobuf \
		golang:snappy:v0.0.1:golang_snappy/src/github.com/golang/snappy \
		golang:sys:61b9204:golang_sys/src/golang.org/x/sys \
		golang:text:v0.3.2:golang_text/src/golang.org/x/text \
		gorilla:mux:v1.6.2:gorilla_mux/src/github.com/gorilla/mux \
		hashicorp:consul:v1.0.8:hashicorp_consul/src/github.com/hashicorp/consul \
		hashicorp:golang-lru:v0.5.3:hashicorp_golang_lru/src/github.com/hashicorp/golang-lru \
		hashicorp:hcl:v1.0.0:hashicorp_hcl/src/github.com/hashicorp/hcl \
		json-iterator:go:v1.1.5:json_iterator_go/src/github.com/json-iterator/go \
		kardianos:osext:ae77be6:kardianos_osext/src/github.com/kardianos/osext \
		kubernetes:apimachinery:def12e6:kubernetes_apimachinery/src/k8s.io/apimachinery \
		magiconair:properties:v1.8.0:magiconair_properties/src/github.com/magiconair/properties \
		matttproud:golang_protobuf_extensions:v1.0.1:matttproud_golang_protobuf_extensions/src/github.com/matttproud/golang_protobuf_extensions \
		mholt:archiver:26cf5bb:mholt_archiver/src/github.com/mholt/archiver \
		mitchellh:mapstructure:bb74f1d:mitchellh_mapstructure/src/github.com/mitchellh/mapstructure \
		moby:moby:v1.13.1:moby_moby/src/github.com/docker/docker \
		modern-go:concurrent:1.0.3:modern_go_concurrent/src/github.com/modern-go/concurrent \
		modern-go:reflect2:1.0.1:modern_go_reflect2/src/github.com/modern-go/reflect2 \
		nwaples:rardecode:e06696f:nwaples_rardecode/src/github.com/nwaples/rardecode \
		patrickmn:go-cache:v2.1.0:patrickmn_go_cache/src/github.com/patrickmn/go-cache \
		pelletier:go-toml:v1.2.0:pelletier_go_toml/src/github.com/pelletier/go-toml \
		philhofer:fwd:v1.0.0:philhofer_fwd/src/github.com/philhofer/fwd \
		pierrec:lz4:v2.0.3:pierrec_lz4/src/github.com/pierrec/lz4 \
		pkg:errors:v0.8.0:pkg_errors/src/github.com/pkg/errors \
		prometheus:client_golang:v0.9.2:prometheus_client_golang/src/github.com/prometheus/client_golang \
		prometheus:client_model:14fe0d1:prometheus_client_model/src/github.com/prometheus/client_model \
		prometheus:common:v0.6.0:prometheus_common/src/github.com/prometheus/common \
		prometheus:procfs:v0.0.4:prometheus_procfs/src/github.com/prometheus/procfs \
		samuel:go-zookeeper:c4fab1a:samuel_go_zookeeper/src/github.com/samuel/go-zookeeper \
		shirou:gopsutil:v2.18.12:shirou_gopsutil/src/github.com/shirou/gopsutil \
		spf13:afero:v1.1.1:spf13_afero/src/github.com/spf13/afero \
		spf13:cobra:v0.0.5:spf13_cobra/src/github.com/spf13/cobra \
		spf13:jwalterweatherman:7c0cea3:spf13_jwalterweatherman/src/github.com/spf13/jwalterweatherman \
		spf13:pflag:v1.0.3:spf13_pflag/src/github.com/spf13/pflag \
		stretchr:testify:v1.2.2:stretchr_testify/src/github.com/stretchr/testify \
		tinylib:msgp:v1.1.0:tinylib_msgp/src/github.com/tinylib/msgp \
		twmb:murmur3:v1.0.0:twmb_murmur3/src/github.com/twmb/murmur3 \
		ugorji:go:8c0409f:ugorji_go/src/github.com/ugorji/go \
		ulikunitz:xz:v0.5.4:ulikunitz_xz/src/github.com/ulikunitz/xz \
		urfave:negroni:v0.3.0:urfave_negroni/src/github.com/urfave/negroni

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
INTEGRATIONS=	active_directory activemq activemq_xml aerospike airflow amazon_msk ambari apache aspdotnet btrfs cacti cassandra cassandra_nodetool ceph cilium cisco_aci clickhouse cockroachdb consul coredns couch couchbase crio datadog_checks_base datadog_checks_downloader datadog_checks_tests_helper directory disk dns_check docker_daemon dotnetclr druid ecs_fargate eks_fargate elastic envoy etcd exchange_server external_dns fluentd gearmand gitlab gitlab_runner go-metro go_expvar gunicorn haproxy harbor hdfs_datanode hdfs_namenode hive http_check hyperv ibm_db2 ibm_mq ibm_was iis istio jboss_wildfly kafka kafka_consumer kong kube_apiserver_metrics kube_controller_manager kube_dns kube_metrics_server kube_proxy kube_scheduler kubelet kubernetes kubernetes_state kyototycoon lighttpd linkerd linux_proc_extras mapr mapreduce marathon mcache mesos_master mesos_slave mongo mysql nagios network nfsstat nginx nginx_ingress_controller openldap openmetrics openstack openstack_controller oracle pdh_check pgbouncer php_fpm postfix postgres powerdns_recursor presto process prometheus rabbitmq redisdb riak riakcs sap_hana snmp solr spark sqlserver squid ssh_check statsd supervisord system_core system_swap tcp_check teamcity tls tokumx tomcat twemproxy twistlock varnish vault vertica vsphere win32_event_log windows_service wmi_check yarn zk

# find integrations-core -name conf.yaml.example | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
CONFFILES=	active_directory activemq activemq_xml aerospike airflow amazon_msk ambari apache aspdotnet btrfs cacti cassandra cassandra_nodetool ceph cilium cisco_aci clickhouse cockroachdb consul coredns couch couchbase crio directory dns_check docker_daemon dotnetclr druid ecs_fargate eks_fargate elastic envoy etcd exchange_server external_dns fluentd gearmand gitlab gitlab_runner go-metro go_expvar gunicorn haproxy harbor hdfs_datanode hdfs_namenode hive http_check hyperv ibm_db2 ibm_mq ibm_was iis istio jboss_wildfly kafka kafka_consumer kong kube_apiserver_metrics kube_controller_manager kube_dns kube_metrics_server kube_proxy kube_scheduler kubelet kubernetes kubernetes_state kyototycoon lighttpd linkerd linux_proc_extras mapr mapreduce marathon mcache mesos_master mesos_slave mongo mysql nagios nfsstat nginx nginx_ingress_controller openldap openmetrics openstack openstack_controller oracle pdh_check pgbouncer php_fpm postfix postgres powerdns_recursor presto process prometheus rabbitmq redisdb riak riakcs sap_hana snmp solr spark sqlserver squid ssh_check statsd supervisord system_core system_swap tcp_check teamcity tls tokumx tomcat twemproxy twistlock varnish vault vertica vsphere win32_event_log windows_service wmi_check yarn zk

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
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/process-agent/process-agent ${STAGEDIR}${DATADOG_PREFIX}/process-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/trace-agent/trace-agent ${STAGEDIR}${DATADOG_PREFIX}/trace-agent
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
