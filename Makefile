# $FreeBSD$

PORTNAME=	datadog
PORTVERSION=	6.12.2
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Datadog Agent

LICENSE=	BSD4CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

#MY_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:devel/py-yaml \
#		${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
#		${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
#		${PYTHON_PKGNAMEPREFIX}requests>=2.6.0:www/py-requests

#BUILD_DEPENDS=	${MY_DEPENDS} \
#		${PYTHON_PKGNAMEPREFIX}invoke>=0.17.0:devel/py-invoke

BUILD_DEPENDS=	go>=1.7:lang/go

#RUN_DEPENDS=   	${MY_DEPENDS} \
#		${PYTHON_PKGNAMEPREFIX}supervisor>=3.3.0:sysutils/py-supervisor \
#		${PYTHON_PKGNAMEPREFIX}boto>=2.36.0:devel/py-boto \
#		${PYTHON_PKGNAMEPREFIX}ntplib>=0.3.3:net/py-ntplib \
#			${PYTHON_PKGNAMEPREFIX}docker>=2.3.0:sysutils/py-docker \
#		${PYTHON_PKGNAMEPREFIX}psutil>=4.4.1:sysutils/py-psutil \
#		${PYTHON_PKGNAMEPREFIX}uptime>=3.0.1:sysutils/py-uptime
#TEST_DEPENDS:= 	${PYTHON_PKGNAMEPREFIX}mock>=1.0.1:devel/py-mock \
#		${PYTHON_PKGNAMEPREFIX}nose>=1.3.4:devel/py-nose \
#		${PYTHON_PKGNAMEPREFIX}flake8>=2.3.0:devel/py-flake8

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	datadog-agent
GO_PKGNAME=     github.com/${GH_ACCOUNT}/${GH_PROJECT}
GH_SUBDIR=      src/github.com/DataDog/datadog-agent
GH_TUPLE=	DataDog:integrations-core:${PORTVERSION}:integrations \
	DataDog:agent-payload:4.8:agent_payload/src/github.com/DataDog/agent-payload \
	DataDog:mmh3:2cfb684:mmh3/src/github.com/DataDog/mmh3 \
	DataDog:gohai:107ebc5:gohai/src/github.com/DataDog/gohai \
        DataDog:viper:v1.7.0:viper/src/github.com/DataDog/viper \
        clbanning:mxj:v2.0:mxj/src/github.com/clbanning/mxj \
        dustin:go-humanize:v1.0.0:gohumanize/src/github.com/dustin/go-humanize \
        json-iterator:go:v1.1.6:go/src/github.com/json-iterator/go \
        modern-go:concurrent:1.0.3:concurrent/src/github.com/modern-go/concurrent \
        modern-go:reflect2:v1.0.1:reflect2/src/github.com/modern-go/reflect2 \
 	beevik:ntp:v0.2.0:ntp/src/github.com/beevik/ntp \
        kubernetes:apimachinery:1799e75:apimachinery/src/k8s.io/apimachinery \
	cihub:seelog:v2.6:seelog/src/github.com/cihub/seelog \
        shirou:gopsutil:v2.19.6:gopsutil/src/github.com/shirou/gopsutil \
	moby:moby:v17.03.2-ce:docker/src/github.com/docker/docker \
        gogo:protobuf:v1.2.1:protobuf/src/github.com/gogo/protobuf \
        go-ini:ini:v1.44.0:ini/src/github.com/go-ini/ini \
        hashicorp:hcl:v1.0.0:hcl/src/github.com/hashicorp/hcl \
	spf13:cobra:v0.0.3:cobra/src/github.com/spf13/cobra \
	spf13:pflag:v1.0.1:pflag/src/github.com/spf13/pflag \
	spf13:afero:v1.1.0:afero/src/github.com/spf13/afero \
	spf13:cast:v1.2.0:cast/src/github.com/spf13/cast \
	spf13:jWalterWeatherman:7c0cea3:jwalterweatherman/src/github.com/spf13/jwalterweatherman \
	fatih:color:v1.6.0:color/src/github.com/fatih/color \
	fsnotify:fsnotify:v1.4.7:fsnotify/src/github.com/fsnotify/fsnotify \
	gorilla:mux:v1.7.3:mux/src/github.com/gorilla/mux \
	kardianos:osext:2bc1f35:osext/src/github.com/kardianos/osext \
	magiconair:properties:v1.7.6:properties/src/github.com/magiconair/properties \
	mholt:archiver:v2.0:archiver/src/github.com/mholt/archiver \
	mitchellh:mapstructure:bb74f1d:mapstructure/src/github.com/mitchellh/mapstructure \
	patrickmn:go-cache:v2.1.0:go_cache/src/github.com/patrickmn/go-cache \
	pelletier:go-toml:v1.1.0:go_toml/src/github.com/pelletier/go-toml \
	golang:net:f5dfe33:net/src/golang.org/x/net \
	golang:sys:37707fd:sys/src/golang.org/x/sys \
	golang:text:4e4a321:text/src/golang.org/x/text \
	ulikunitz:xz:v0.5.4:xz/src/github.com/ulikunitz/xz \
	urfave:negroni:v0.2.0:negroni/src/github.com/urfave/negroni \
	stretchr:testify:v1.2.1:testify/src/github.com/stretchr/testify \
	nwaples:rardecode:e06696f:rardecode/src/github.com/nwaples/rardecode \
	go-yaml:yaml:v2.2.2:yaml2/src/gopkg.in/yaml.v2 \
	dsnet:compress:cc9eb1d:compress/src/github.com/dsnet/compress


USES=           go
#USES=		python:2.7+
#USE_PYTHON=	autoplist distutils
#SHEBANG_FILES=	agent.py ddagent.py dogstatsd.py
#python_OLD_CMD=	/opt/datadog-agent/embedded/bin/python

USE_RC_SUBR=   	${PORTNAME}-collector ${PORTNAME}-dogstatsd

RUNDIR?=	/var/run/${PORTNAME}
LOGDIR?=	/var/log/${PORTNAME}

USERS=		datadog
GROUPS=		${USERS}

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

CONFFILES=	conf.d/*
#CHECKFILES=	checks.d/*

PORTDOCS=	README.md CHANGELOG.md CONTRIBUTING.md LICENSE

OPTIONS_DEFINE=	DOCS

#post-extract:
#		@${MV} ${WRKSRC_integrations} ${WRKSRC}/integrations

#post-patch:
#		@${REINPLACE_CMD} -e 's|/etc/dd-agent|${ETCDIR}|g' \
#			${WRKSRC}/config.py \
#			${WRKSRC}/utils/flare.py \
#			${WRKSRC}/datadog.conf.example
#		@${REINPLACE_CMD} -e 's|%%RUNDIR%%|${RUNDIR}|g' \
#			${WRKSRC}/agent.py \
#			${WRKSRC}/dogstatsd.py

BUILD_USER?=    ${USER}

#LD_FLAG_X_PREFIX=       -X ${GO_PKGNAME}/vendor/${GO_PKGNAME:H}/common/version
LD_FLAG_X_PREFIX=	-X ${GO_PKGNAME}/pkg/version

LD_FLAG_STRING= -s \
	${LD_FLAG_X_PREFIX}.AgentVersion=${PORTVERSION}
#	${LD_FLAG_X_PREFIX}.Revision=${PORTREVISION} \
#	${LD_FLAG_X_PREFIX}.Branch=release-${PORTVERSION:R} \
#	${LD_FLAG_X_PREFIX}.BuildUser=${BUILD_USER}

# LD_FLAG_STRING=-X main.GitDescribe=${DISTVERSIONFULL}

PROMETHEUS_BINARIES=    agent

do-build:
.for bin in ${PROMETHEUS_BINARIES}
	( cd ${GO_WRKSRC}/cmd/${bin} ; \
		${SETENV} ${MAKE_ENV} ${BUILD_ENV} GOPATH=${WRKSRC} go build -tags 'log process' -ldflags "${LD_FLAG_STRING}" )
.endfor

#post-install:
#		${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
#		${MKDIR} ${STAGEDIR}${ETCDIR}/checks.d
#		${MKDIR} ${STAGEDIR}${RUNDIR}
#		${MKDIR} ${STAGEDIR}${LOGDIR}
#		${MKDIR} ${STAGEDIR}${DOCSDIR}
#		${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
#		${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d

#.for i in ${CHECKFILES}
#		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d
#.endfor

#		${INSTALL_DATA} ${WRKSRC}/datadog.conf.example ${STAGEDIR}${ETCDIR}/${PORTNAME}.conf.sample

#.for i in ${CONFFILES}
#		${INSTALL_DATA} ${WRKSRC}/${i}.example ${STAGEDIR}${EXAMPLESDIR}
#		${INSTALL_DATA} ${WRKSRC}/${i}.default ${STAGEDIR}${ETCDIR}/conf.d/
#.endfor

#.for i in ${PORTDOCS}
#		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${DOCSDIR}
#.endfor

#		${INSTALL_DATA} ${WRKSRC}/datadog-cert.pem ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}

#regression-test: build
#		@cd ${WRKSRC} && ${PYTHON_CMD} ${PYSETUP} test

.include <bsd.port.mk>
