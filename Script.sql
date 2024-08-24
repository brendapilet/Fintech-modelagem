-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2023-11-04 19:18:09 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_ftc_cartao (
    nr_cartao                NUMBER(16) NOT NULL,
    t_ftc_usuario_id_usuario INTEGER NOT NULL,
    dt_emissao               DATE NOT NULL,
    dt_validade              DATE NOT NULL,
    lt_credito               NUMBER(15, 2) NOT NULL,
    tp_cartao                VARCHAR2(10 CHAR) NOT NULL,
    nr_cvv                   NUMBER(3) NOT NULL,
    nr_conta                 NUMBER(40) NOT NULL
);

ALTER TABLE t_ftc_cartao ADD CONSTRAINT t_ftc_cartao_pk PRIMARY KEY ( nr_cartao );

CREATE TABLE t_ftc_conta (
    nr_conta    NUMBER(40) NOT NULL,
    id_usuario  INTEGER NOT NULL,
    tl_conta    VARCHAR2(30 CHAR) NOT NULL,
    tp_conta    VARCHAR2(50 CHAR) NOT NULL,
    nm_banco    VARCHAR2(30 CHAR) NOT NULL,
    vl_saldo    NUMBER(15, 2) NOT NULL,
    dt_abertura DATE NOT NULL
);

ALTER TABLE t_ftc_conta ADD CONSTRAINT t_ftc_conta_pk PRIMARY KEY ( nr_conta );

CREATE TABLE t_ftc_educacao (
    id_recurso    INTEGER NOT NULL,
    id_usuario    INTEGER NOT NULL,
    tl_recurso    VARCHAR2(250 CHAR) NOT NULL,
    ds_recurso    CLOB NOT NULL,
    co_recurso    CLOB NOT NULL,
    dt_publicacao DATE NOT NULL,
    at_recurso    VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE t_ftc_educacao ADD CONSTRAINT t_ftc_educacao_pk PRIMARY KEY ( id_recurso );

CREATE TABLE t_ftc_gasto (
    id_gasto             INTEGER NOT NULL,
    t_ftc_conta_nr_conta NUMBER(40) NOT NULL,
    cg_gasto             VARCHAR2(50 CHAR) NOT NULL,
    ds_gasto             VARCHAR2(150 CHAR) NOT NULL,
    vl_gasto             NUMBER(15, 2) NOT NULL,
    dt_hora              DATE NOT NULL,
    id_transacao         INTEGER NOT NULL
);

ALTER TABLE t_ftc_gasto ADD CONSTRAINT t_ftc_gasto_pk PRIMARY KEY ( id_gasto );

CREATE TABLE t_ftc_investimento (
    id_investimento INTEGER NOT NULL,
    nr_conta        NUMBER(40) NOT NULL,
    tp_investimento VARCHAR2(150 CHAR) NOT NULL,
    vl_investimento NUMBER(15, 2) NOT NULL,
    dt_compra       DATE NOT NULL,
    dt_vencimento   DATE NOT NULL,
    tx_rendimento   NUMBER(5, 2) NOT NULL
);

ALTER TABLE t_ftc_investimento ADD CONSTRAINT t_ftc_investimento_pk PRIMARY KEY ( id_investimento );

CREATE TABLE t_ftc_notificacao (
    id_notificacao INTEGER NOT NULL,
    id_usuario     INTEGER NOT NULL,
    tp_notificacao VARCHAR2(50 CHAR) NOT NULL,
    mg_notificacao CLOB NOT NULL,
    dt_hora        DATE NOT NULL
);

ALTER TABLE t_ftc_notificacao ADD CONSTRAINT t_ftc_notificacao_pk PRIMARY KEY ( id_notificacao );

CREATE TABLE t_ftc_objetivo (
    id_objetivo INTEGER NOT NULL,
    id_usuario  INTEGER NOT NULL,
    ds_objetivo VARCHAR2(150 CHAR) NOT NULL,
    vl_objetivo NUMBER(15, 2) NOT NULL,
    dt_alvo     DATE NOT NULL,
    st_objetivo VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE t_ftc_objetivo ADD CONSTRAINT t_ftc_objetivo_pk PRIMARY KEY ( id_objetivo );

CREATE TABLE t_ftc_recebimento (
    id_recebimento       INTEGER NOT NULL,
    t_ftc_conta_nr_conta NUMBER(40) NOT NULL,
    or_recebimento       VARCHAR2(150 CHAR) NOT NULL,
    vl_recebimento       NUMBER(15, 2) NOT NULL,
    dt_hora              DATE NOT NULL,
    id_transacao         INTEGER NOT NULL
);

ALTER TABLE t_ftc_recebimento ADD CONSTRAINT t_ftc_recebimento_pk PRIMARY KEY ( id_recebimento );

CREATE TABLE t_ftc_transacao (
    id_transacao INTEGER NOT NULL,
    nr_conta     NUMBER(40) NOT NULL,
    tp_transacao VARCHAR2(50 CHAR) NOT NULL,
    dt_hora      DATE NOT NULL,
    vl_transacao NUMBER(15, 2) NOT NULL,
    cn_origem    VARCHAR2(20 CHAR) NOT NULL,
    cn_destino   VARCHAR2(20 CHAR) NOT NULL,
    nr_cartao    NUMBER(16) NOT NULL
);

ALTER TABLE t_ftc_transacao ADD CONSTRAINT t_ftc_transacao_pk PRIMARY KEY ( id_transacao );

CREATE TABLE t_ftc_usuario (
    id_usuario       INTEGER NOT NULL,
    nm_usuario       VARCHAR2(150 CHAR) NOT NULL,
    em_usuario       VARCHAR2(150 CHAR) NOT NULL,
    nr_contato       NUMBER(20) NOT NULL,
    ds_identificacao VARCHAR2(20 CHAR) NOT NULL,
    sn_usuario       VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE t_ftc_usuario ADD CONSTRAINT t_ftc_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_ftc_cartao
    ADD CONSTRAINT t_ftc_cartao_t_ftc_conta_fk FOREIGN KEY ( nr_conta )
        REFERENCES t_ftc_conta ( nr_conta );

ALTER TABLE t_ftc_cartao
    ADD CONSTRAINT t_ftc_cartao_t_ftc_usuario_fk FOREIGN KEY ( t_ftc_usuario_id_usuario )
        REFERENCES t_ftc_usuario ( id_usuario );

ALTER TABLE t_ftc_conta
    ADD CONSTRAINT t_ftc_conta_t_ftc_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_ftc_usuario ( id_usuario );

ALTER TABLE t_ftc_educacao
    ADD CONSTRAINT t_ftc_educacao_t_ftc_us_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_ftc_usuario ( id_usuario );

ALTER TABLE t_ftc_gasto
    ADD CONSTRAINT t_ftc_gasto_t_ftc_conta_fk FOREIGN KEY ( t_ftc_conta_nr_conta )
        REFERENCES t_ftc_conta ( nr_conta );

ALTER TABLE t_ftc_gasto
    ADD CONSTRAINT t_ftc_gasto_t_ftc_transacao_fk FOREIGN KEY ( id_transacao )
        REFERENCES t_ftc_transacao ( id_transacao );

ALTER TABLE t_ftc_investimento
    ADD CONSTRAINT t_ftc_investimento_t_ftc_ct_fk FOREIGN KEY ( nr_conta )
        REFERENCES t_ftc_conta ( nr_conta );

ALTER TABLE t_ftc_notificacao
    ADD CONSTRAINT t_ftc_notificacao_t_ftc_us_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_ftc_usuario ( id_usuario );

ALTER TABLE t_ftc_objetivo
    ADD CONSTRAINT t_ftc_objetivo_t_ftc_us_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_ftc_usuario ( id_usuario );

ALTER TABLE t_ftc_recebimento
    ADD CONSTRAINT t_ftc_recebimento_t_ftc_ct_fk FOREIGN KEY ( t_ftc_conta_nr_conta )
        REFERENCES t_ftc_conta ( nr_conta );

ALTER TABLE t_ftc_recebimento
    ADD CONSTRAINT t_ftc_recebimento_t_ftc_trn_fk FOREIGN KEY ( id_transacao )
        REFERENCES t_ftc_transacao ( id_transacao );

ALTER TABLE t_ftc_transacao
    ADD CONSTRAINT t_ftc_transacao_t_ftc_conta_fk FOREIGN KEY ( nr_conta )
        REFERENCES t_ftc_conta ( nr_conta );

ALTER TABLE t_ftc_transacao
    ADD CONSTRAINT t_ftc_transacao_t_ftc_ct_fk FOREIGN KEY ( nr_cartao )
        REFERENCES t_ftc_cartao ( nr_cartao );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
