# $FreeBSD$

PORTNAME=	datadog
PORTVERSION=	5.8.5
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Data Dog agent

LICENSE=	BSD4CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
		${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
		${PYTHON_PKGNAMEPREFIX}requests>=2.6.0:www/py-requests
RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
		${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
		${PYTHON_PKGNAMEPREFIX}boto>=2.36.0:devel/py-boto \
		${PYTHON_PKGNAMEPREFIX}ntplib>=0.3.3:net/py-ntplib \
		${PYTHON_PKGNAMEPREFIX}requests>=2.6.0:www/py-requests \
		${PYTHON_PKGNAMEPREFIX}psutil>=2.1.1:sysutils/py-psutil \
		${PYTHON_PKGNAMEPREFIX}uptime>=3.0.1:sysutils/py-uptime
TEST_DEPENDS:=	${PYTHON_PKGNAMEPREFIX}mock>=1.0.1:devel/py-mock \
		${PYTHON_PKGNAMEPREFIX}nose>=1.3.4:devel/py-nose \
		${PYTHON_PKGNAMEPREFIX}flake8>=2.3.0:devel/py-flake8

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	dd-agent

USES=		python:2.7+ shebangfix
USE_PYTHON=	autoplist distutils
SHEBANG_FILES=	agent.py ddagent.py dogstatsd.py
python_OLD_CMD=	/opt/datadog-agent/embedded/bin/python

USE_RC_SUBR=	${PORTNAME}-agent

PIDDIR?=	/var/run/${PORTNAME}
LOGDIR?=	/var/log/${PORTNAME}

USERS=          datadog
GROUPS=         ${USERS}

SUB_FILES=	pkg-message datadog-agent
SUB_LIST=	PIDDIR=${PIDDIR} \
		LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD}

PLIST_SUB+=	PIDDIR=${PIDDIR} \
		LOGDIR=${LOGDIR} \
		USERS=${USERS} \
		GROUPS=${GROUPS}

CONFFILES=	conf.d/*
CHECKFILES=	checks.d/*

PORTDOCS=	README.md CHANGELOG.md CONTRIBUTING.md LICENSE

OPTIONS_DEFINE=	DOCS

post-patch:
		@${REINPLACE_CMD} -e 's|/etc/dd-agent|${ETCDIR}|g' \
			${WRKSRC}/config.py \
			${WRKSRC}/utils/flare.py \
			${WRKSRC}/datadog.conf.example

post-install:
		${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
		${MKDIR} ${STAGEDIR}${ETCDIR}/checks.d
		${MKDIR} ${STAGEDIR}${PIDDIR}
		${MKDIR} ${STAGEDIR}${LOGDIR}
		${MKDIR} ${STAGEDIR}${DOCSDIR}
		${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
		${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d

.for i in ${CHECKFILES}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d
.endfor

		${INSTALL_DATA} ${WRKSRC}/datadog.conf.example ${STAGEDIR}${ETCDIR}/${PORTNAME}.conf.sample

.for i in ${CONFFILES}
	        ${INSTALL_DATA} ${WRKSRC}/${i}.example ${STAGEDIR}${EXAMPLESDIR}
	        ${INSTALL_DATA} ${WRKSRC}/${i}.default ${STAGEDIR}${ETCDIR}/conf.d/
.endfor

.for i in ${PORTDOCS}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${DOCSDIR}
.endfor

		${INSTALL_DATA} ${WRKSRC}/datadog-cert.pem ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}

regression-test: build
		@cd ${WRKSRC} && ${PYTHON_CMD} ${PYSETUP} test

.include <bsd.port.mk>
