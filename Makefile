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
		cmake>=3.18:devel/cmake \
		python>=3.7:lang/python

USES=		go:modules python:3.7+

DATADOG_PREFIX=	/var/db/datadog
LOGDIR=		/var/log/${PORTNAME}

USE_GITHUB=	yes
GH_ACCOUNT=	${PORTNAME}
GH_PROJECT=	datadog-agent
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}
GH_SUBDIR=	src/github.com/DataDog/datadog-agent
GH_TAGNAME=	${DISTVERSION}

# For list of modules you can check:
# https://github.com/DataDog/datadog-agent/blob/${DISTVERSION}/Gopkg.toml
GH_TUPLE=	DataDog:agent-payload:4.24.0:DataDog_agent_payload/vendor/github.com/DataDog/agent-payload \
		DataDog:cast:1ee8c8b:DataDog_cast/vendor/github.com/spf13/cast \
		DataDog:datadog-go:2.1.0:DataDog_datadog_go/vendor/github.com/DataDog/datadog-go \
		DataDog:gohai:master:DataDog_gohai/vendor/github.com/DataDog/gohai \
		DataDog:gopsutil:3ca45fa:DataDog_gopsutil/vendor/github.com/DataDog/gopsutil \
		DataDog:mmh3:2cfb684:DataDog_mmh3/vendor/github.com/DataDog/mmh3 \
		DataDog:viper:v1.7.0:DataDog_viper/vendor/github.com/DataDog/viper \
		DataDog:zstd:2b373cb:DataDog_zstd/vendor/github.com/DataDog/zstd.v0.5 \
		aws:aws-sdk-go:v1.12.79:aws_aws_sdk_go/vendor/github.com/aws/aws-sdk-go \
		beevik:ntp:v0.2.0:beevik_ntp/vendor/github.com/beevik/ntp \
		benesch:cgosymbolizer:bec6fe6:benesch_cgosymbolizer/vendor/github.com/benesch/cgosymbolizer \
		blabber:go-freebsd-sysctl:dcd5a22:blabber_go_freebsd_sysctl/vendor/github.com/blabber/go-freebsd-sysctl \
		cihub:seelog:v2.6:cihub_seelog/vendor/github.com/cihub/seelog \
		clbanning:mxj:v1.8:clbanning_mxj/vendor/github.com/clbanning/mxj \
		containerd:containerd:v1.2.2:containerd_containerd/vendor/github.com/containerd/containerd \
		coreos:etcd:v3.2.23:coreos_etcd/vendor/github.com/coreos/etcd \
		coreos:go-semver:v0.2.0:coreos_go_semver/vendor/github.com/coreos/go-semver \
		coreos:go-systemd:v16:coreos_go_systemd/vendor/github.com/coreos/go-systemd \
		coreos:pkg:v4:coreos_pkg/vendor/github.com/coreos/pkg \
		docker:go-connections:v0.3.0:docker_go_connections/vendor/github.com/docker/go-connections \
		dsnet:compress:cc9eb1d:dsnet_compress/vendor/github.com/dsnet/compress \
		dustin:go-humanize:9f541cc:dustin_go_humanize/vendor/github.com/dustin/go-humanize \
		fatih:color:v1.7.0:fatih_color/vendor/github.com/fatih/color \
		fsnotify:fsnotify:v1.4.7:fsnotify_fsnotify/vendor/github.com/fsnotify/fsnotify \
		go-ini:ini:v1.37.0:go-ini_ini/vendor/github.com/go-ini/ini \
		go-yaml:yaml:v2.2.2:go-yaml_yaml/vendor/gopkg.in/yaml.v2 \
		gogo:protobuf:v1.0.0:gogo_protobuf/vendor/github.com/gogo/protobuf \
		golang:net:97aa3a5:golang_net/vendor/golang.org/x/net \
		golang:snappy:2e65f85:golang_snappy/vendor/github.com/golang/snappy \
		golang:sys:61b9204:golang_sys/vendor/golang.org/x/sys \
		golang:text:v0.3.0:golang_text/vendor/golang.org/x/text \
		gorilla:mux:v1.6.2:gorilla_mux/vendor/github.com/gorilla/mux \
		hashicorp:consul:v1.0.7:hashicorp_consul/vendor/github.com/hashicorp/consul \
		hashicorp:hcl:ef8a98b:hashicorp_hcl/vendor/github.com/hashicorp/hcl \
		json-iterator:go:v1.1.5:json-iterator_go/vendor/github.com/json-iterator/go \
		kardianos:osext:ae77be6:kardianos_osext/vendor/github.com/kardianos/osext \
		kubernetes:apimachinery:def12e6:kubernetes_apimachinery/vendor/k8s.io/apimachinery \
		magiconair:properties:v1.8.0:magiconair_properties/vendor/github.com/magiconair/properties \
		mholt:archiver:26cf5bb:mholt_archiver/vendor/github.com/mholt/archiver \
		mitchellh:mapstructure:bb74f1d:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
		moby:moby:v1.13.1:moby_moby/vendor/github.com/docker/docker \
		modern-go:concurrent:1.0.3:modern-go_concurrent/vendor/github.com/modern-go/concurrent \
		modern-go:reflect2:1.0.1:modern-go_reflect2/vendor/github.com/modern-go/reflect2 \
		nwaples:rardecode:e06696f:nwaples_rardecode/vendor/github.com/nwaples/rardecode \
		patrickmn:go-cache:v2.1.0:patrickmn_go_cache/vendor/github.com/patrickmn/go-cache \
		pelletier:go-toml:v1.2.0:pelletier_go_toml/vendor/github.com/pelletier/go-toml \
		philhofer:fwd:v1.0.0:philhofer_fwd/vendor/github.com/philhofer/fwd \
		pierrec:lz4:v2.0.3:pierrec_lz4/vendor/github.com/pierrec/lz4 \
		pkg:errors:v0.8.0:pkg_errors/vendor/github.com/pkg/errors \
		samuel:go-zookeeper:c4fab1a:samuel_go_zookeeper/vendor/github.com/samuel/go-zookeeper \
		shirou:gopsutil:v2.18.12:shirou_gopsutil/vendor/github.com/shirou/gopsutil \
		spf13:afero:v1.1.1:spf13_afero/vendor/github.com/spf13/afero \
		spf13:cobra:v0.0.3:spf13_cobra/vendor/github.com/spf13/cobra \
		spf13:jwalterweatherman:7c0cea3:spf13_jwalterweatherman/vendor/github.com/spf13/jwalterweatherman \
		spf13:pflag:v1.0.1:spf13_pflag/vendor/github.com/spf13/pflag \
		stretchr:testify:v1.2.2:stretchr_testify/vendor/github.com/stretchr/testify \
		tinylib:msgp:v1.1.0:tinylib_msgp/vendor/github.com/tinylib/msgp \
		ugorji:go:8c0409f:ugorji_go/vendor/github.com/ugorji/go \
		ulikunitz:xz:v0.5.4:ulikunitz_xz/vendor/github.com/ulikunitz/xz \
		urfave:negroni:v0.3.0:urfave_negroni/vendor/github.com/urfave/negroni

USE_RC_SUBR=	${PORTNAME}-agent-process ${PORTNAME}-agent-trace ${PORTNAME}-agent

GID_FILES=	${PATCHDIR}/GIDs
UID_FILES=	${PATCHDIR}/UIDs

USERS=	dd-agent
GROUPS=	${USERS}

SUB_FILES=	pkg-message pkg-deinstall
SUB_LIST=	RUNDIR=${RUNDIR} \
		LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD} \
		USER=${USERS} \
		PORTNAME=${PORTNAME}

PLIST_SUB+=	RUNDIR=${RUNDIR} \
		LOGDIR=${LOGDIR} \
		USER=${USERS} \
		GROUP=${GROUPS} \
		PORTNAME=${PORTNAME}

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
USE_LDCONFIG=	${DATADOG_PREFIX}/embedded/lib

PYTHON_BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}invoke>=1.2.0_1:devel/py-invoke \
			${PYTHON_PKGNAMEPREFIX}reno>=2.9.2:textproc/py-reno \
			${PYTHON_PKGNAMEPREFIX}docker>=3.0.1:sysutils/py-docker \
			${PYTHON_PKGNAMEPREFIX}yaml>=5.1:devel/py-yaml \
			${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
			${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
			${PYTHON_PKGNAMEPREFIX}requests>=2.21.0:www/py-requests \
			${PYTHON_PKGNAMEPREFIX}toml>=0.9.4:textproc/py-toml

EC2_VARS=	agent_build_tags+=ec2
ETCD_VARS=	agent_build_tags+=etcd
GCE_VARS=	agent_build_tags+=gce
JMX_VARS=	agent_build_tags+=jmx
LOG_VARS=	agent_build_tags+=log
PROCESS_VARS=	agent_build_tags+=process
ZK_VARS=	agent_build_tags+=zk
ZLIB_VARS=	agent_build_tags+=zlib

BUILD_USER?=	${USER}

LD_FLAG_X_PREFIX=	-X ${GO_WRKSRC}/pkg/version
LD_FLAG_STRING=		-s ${LD_FLAG_X_PREFIX}.Version=${DISTVERSION}
LD_FLAG_X_PREFIX=	-X ${GO_PKGNAME}/pkg/version
LD_FLAG_STRING=		-s ${LD_FLAG_X_PREFIX}.AgentVersion=${DISTVERSION}

DATADOG_BINARIES=	agent dogstatsd process-agent trace-agent

# find integrations-core -name setup.py | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
INTEGRATIONS=	active_directory activemq activemq_xml aerospike \
			agent_metrics ambari apache aspdotnet btrfs cacti \
			cassandra cassandra_nodetool ceph cisco_aci \
			cockroachdb consul coredns couch couchbase crio \
			datadog_checks_base datadog_checks_downloader \
			datadog_checks_tests_helper directory disk \
			dns_check dotnetclr ecs_fargate \
			elastic envoy etcd exchange_server fluentd \
			gearmand gitlab gitlab_runner go-metro go_expvar \
			gunicorn haproxy harbor hdfs_datanode hdfs_namenode \
			hive http_check hyperv ibm_db2 ibm_mq ibm_was iis \
			istio jboss_wildfly kafka kafka_consumer kong \
			kube_apiserver_metrics kube_controller_manager \
			kube_dns kube_metrics_server kube_proxy \
			kube_scheduler kubelet kubernetes kubernetes_state \
			kyototycoon lighttpd linkerd linux_proc_extras \
			mapreduce marathon mcache mesos_master mesos_slave \
			mongo mysql nagios network nfsstat nginx \
			nginx_ingress_controller ntp openldap openmetrics \
			openstack openstack_controller oracle pdh_check \
			pgbouncer php_fpm postfix postgres powerdns_recursor \
			presto process prometheus rabbitmq redisdb riak \
			riakcs snmp solr spark sqlserver squid ssh_check \
			statsd supervisord system_core system_swap tcp_check \
			teamcity tls tokumx tomcat twemproxy twistlock \
			varnish vault vsphere win32_event_log windows_service \
			wmi_check yarn zk

# find integrations-core -name conf.yaml.example | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
CONFFILES=	active_directory activemq activemq_xml aerospike ambari \
			apache aspdotnet btrfs cacti cassandra \
			cassandra_nodetool ceph cisco_aci cockroachdb consul \
			coredns couch couchbase crio directory dns_check \
			dotnetclr ecs_fargate elastic envoy etcd \
			exchange_server fluentd gearmand gitlab gitlab_runner \
			go-metro go_expvar gunicorn haproxy harbor \
			hdfs_datanode hdfs_namenode hive http_check hyperv \
			ibm_db2 ibm_mq ibm_was iis istio jboss_wildfly kafka \
			kafka_consumer kong kube_apiserver_metrics \
			kube_controller_manager kube_dns kube_metrics_server \
			kube_proxy kube_scheduler kubelet kubernetes \
			kubernetes_state kyototycoon lighttpd linkerd \
			linux_proc_extras mapreduce marathon mcache \
			mesos_master mesos_slave mongo mysql nagios \
			nfsstat nginx nginx_ingress_controller openldap \
			openmetrics openstack openstack_controller oracle \
			pdh_check pgbouncer php_fpm postfix postgres \
			powerdns_recursor presto process prometheus rabbitmq \
			redisdb riak riakcs snmp solr spark sqlserver squid \
			ssh_check statsd supervisord system_core system_swap \
			tcp_check teamcity tls tokumx tomcat twemproxy \
			twistlock varnish vault vsphere win32_event_log \
			windows_service wmi_check yarn zk

post-extract:
	@${MKDIR} ${WRKSRC}/vendor/github.com/vishvananda
	@${RLN} ${WRKSRC_mdlayher_netlink} ${WRKSRC}/vendor/github.com/vishvananda/netlink

do-build:
# Build rtloader (Previously called six)
	(cd ${WRKSRC}/rtloader && ${SETENV} ${MAKE_ENV} ${BUILD_ENV} \
		cmake -DBUILD_DEMO:BOOL=OFF \
		-DCMAKE_INSTALL_PREFIX:PATH=${DATADOG_PREFIX}/embedded \
		-DDISABLE_PYTHON2=ON && make -C .)

# Build go binaries
.for bin in ${DATADOG_BINARIES}
	(cd ${GO_WRKSRC}/cmd/${bin}; \
		${SETENV} ${MAKE_ENV} ${BUILD_ENV} GOPATH=${GO_WRKSRC} \
		CGO_CFLAGS="-w -I${WRKSRC}/rtloader/include -I${WRKSRC}/rtloader/common" \
		CGO_LDFLAGS="-L${WRKSRC}/rtloader/rtloader" go build -tags \
		'${AGENT_BUILD_TAGS}' -o ${GO_WRKSRC}/cmd/${bin}/${bin} -ldflags "${LD_FLAG_STRING}")
.endfor

# Generate config files
	go run ${GO_WRKSRC}/pkg/config/render_config.go agent \
	${GO_WRKSRC}/pkg/config/config_template.yaml \
	${GO_WRKSRC}/cmd/agent/dist/datadog.yaml

do-install:
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/embedded/datadog_checks
	${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
	${MKDIR} ${STAGEDIR}${LOGDIR}
	${MKDIR} ${STAGEDIR}${RUNDIR}

.for doc in README.md CHANGELOG.rst CONTRIBUTING.md LICENSE
	(${INSTALL_MAN} ${WRKSRC}/${doc} ${STAGEDIR}${DATADOG_PREFIX})
.endfor

	# Install binaries
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/process-agent/process-agent ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin/process-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/trace-agent/trace-agent ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin/trace-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/agent/agent	${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	cd ${GO_WRKSRC}/cmd/agent && ${COPYTREE_SHARE} dist ${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	cd ${GO_WRKSRC}/pkg/status/dist && ${COPYTREE_SHARE} templates ${STAGEDIR}${DATADOG_PREFIX}/bin/agent/dist

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

.include <bsd.port.mk>
