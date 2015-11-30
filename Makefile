# $FreeBSD$

PORTNAME=	datadog
PORTVERSION=	5.6.1
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Data Dog agent

LICENSE=	BSD4CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:${PORTSDIR}/devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.3:${PORTSDIR}/devel/py-simplejson \
		${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:${PORTSDIR}/www/py-tornado
RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:${PORTSDIR}/devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.3:${PORTSDIR}/devel/py-simplejson \
		${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:${PORTSDIR}/www/py-tornado \
		${PYTHON_PKGNAMEPREFIX}boto>=2.36.0:${PORTSDIR}/devel/py-boto \
		${PYTHON_PKGNAMEPREFIX}ntplib>=0.3.3:${PORTSDIR}/net/py-ntplib \
		${PYTHON_PKGNAMEPREFIX}requests>=2.6.0:${PORTSDIR}/www/py-requests \
		${PYTHON_PKGNAMEPREFIX}supervisor>=3.0:${PORTSDIR}/sysutils/py-supervisor \
		${PYTHON_PKGNAMEPREFIX}psutil>=2.1.1:${PORTSDIR}/sysutils/py-psutil
TEST_DEPENDS:=	${PYTHON_PKGNAMEPREFIX}mock>=1.0.1:${PORTSDIR}/devel/py-mock \
		${PYTHON_PKGNAMEPREFIX}nose>=1.3.4:${PORTSDIR}/devel/py-nose \
		${PYTHON_PKGNAMEPREFIX}flake8>=2.3.0:${PORTSDIR}/devel/py-flake8

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	dd-agent

USES=		python
USE_PYTHON=	autoplist distutils

PIDDIR?=	/var/run/${PORTNAME}
LOGDIR?=	/var/log/${PORTNAME}

SUB_FILES=	supervisord.conf pkg-message
SUB_LIST=	PIDDIR=${PIDDIR} \
		LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD}

PLIST_SUB=	PIDDIR=${PIDDIR} LOGDIR=${LOGDIR}

CONFFILES=	conf.d/*
CHECKFILES=	checks.d/*

PORTDOCS=	README.md CHANGELOG.md CONTRIBUTING.md LICENSE

OPTIONS_DEFINE=	DOCS

post-patch:
		@${REINPLACE_CMD} -e 's|/etc/dd-agent|${ETCDIR}|g' \
			${WRKSRC}/config.py \
			${WRKSRC}/utils/flare.py \
			${WRKSRC}/datadog.conf.example
		@${REINPLACE_CMD} -e 's|datadog.conf|../${PORTNAME}.conf|g' ${WRKSRC}/config.py

post-install:
		${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
		${MKDIR} ${STAGEDIR}${PIDDIR}
		${MKDIR} ${STAGEDIR}${LOGDIR}
		${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d

		${INSTALL_DATA} ${WRKSRC}/datadog.conf.example ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample
		${INSTALL_DATA} ${WRKSRC}/datadog-cert.pem ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}

		${MKDIR} ${STAGEDIR}${DOCSDIR}

		${INSTALL_DATA} ${WRKDIR}/supervisord.conf ${STAGEDIR}${ETCDIR}

.for i in ${CHECKFILES}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d
.endfor

.for i in ${CONFFILES}
	        ${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${ETCDIR}/conf.d
.endfor

.for i in ${PORTDOCS}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${DOCSDIR}
.endfor

regression-test: build
		@cd ${WRKSRC} && ${PYTHON_CMD} ${PYSETUP} test

.include <bsd.port.mk>
