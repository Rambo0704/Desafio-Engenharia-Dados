
CREATE TABLE GuestChecks (
    guestCheckId BIGINT PRIMARY KEY,
    chkNum INT,
    opnBusDt DATE,
    opnUTC TIMESTAMP,
    opnLcl TIMESTAMP,
    clsdBusDt DATE,
    clsdUTC TIMESTAMP,
    clsdLcl TIMESTAMP,
    lastTransUTC TIMESTAMP,
    lastTransLcl TIMESTAMP,
    lastUpdatedUTC TIMESTAMP,
    lastUpdatedLcl TIMESTAMP,
    clsdFlag BOOLEAN,
    gstCnt INT,
    subTtl DECIMAL(10, 2),
    nonTxblSlsTtl DECIMAL(10, 2),
    chkTtl DECIMAL(10, 2),
    dscTtl DECIMAL(10, 2),
    payTtl DECIMAL(10, 2),
    balDueTtl DECIMAL(10, 2),
    rvcNum INT,
    otNum INT,
    ocNum INT,
    tblNum INT,
    tblName VARCHAR(50),
    empNum INT,
    numSrvcRd INT,
    numChkPrntd INT
);

CREATE TABLE GuestCheckTaxes (
    id SERIAL PRIMARY KEY,
    guestCheckId BIGINT REFERENCES GuestChecks(guestCheckId),
    taxNum INT,
    txblSlsTtl DECIMAL(10, 2),
    taxCollTtl DECIMAL(10, 2),
    taxRate DECIMAL(5, 2),
    type INT
);

CREATE TABLE DetailLines (
    guestCheckLineItemId BIGINT PRIMARY KEY,
    guestCheckId BIGINT REFERENCES GuestChecks(guestCheckId),
    rvcNum INT,
    dtlOtNum INT,
    dtlOcNum INT,
    lineNum INT,
    dtlId INT,
    detailUTC TIMESTAMP,
    detailLcl TIMESTAMP,
    lastUpdateUTC TIMESTAMP,
    lastUpdateLcl TIMESTAMP,
    busDt DATE,
    wsNum INT,
    dspTtl DECIMAL(10, 2),
    dspQty DECIMAL(10, 2),
    aggTtl DECIMAL(10, 2),
    aggQty DECIMAL(10, 2),
    chkEmpId BIGINT,
    chkEmpNum INT,
    svcRndNum INT,
    seatNum INT
);

CREATE TABLE MenuItems (
    guestCheckLineItemId BIGINT PRIMARY KEY REFERENCES DetailLines(guestCheckLineItemId),
    miNum INT,
    modFlag BOOLEAN,
    inclTax DECIMAL(10, 4),
    activeTaxes VARCHAR(50),
    prcLvl INT
);

CREATE TABLE Discounts (
    guestCheckLineItemId BIGINT PRIMARY KEY REFERENCES DetailLines(guestCheckLineItemId),
    discountId INT,
    amount DECIMAL(10, 2),
    description TEXT
);

CREATE TABLE ServiceCharges (
    guestCheckLineItemId BIGINT PRIMARY KEY REFERENCES DetailLines(guestCheckLineItemId),
    serviceChargeId INT,
    amount DECIMAL(10, 2),
    description TEXT
);

CREATE TABLE TenderMedia (
    guestCheckLineItemId BIGINT PRIMARY KEY REFERENCES DetailLines(guestCheckLineItemId),
    mediaType VARCHAR(50),
    amount DECIMAL(10, 2),
    authCode VARCHAR(100)
);

CREATE TABLE ErrorCodes (
    guestCheckLineItemId BIGINT PRIMARY KEY REFERENCES DetailLines(guestCheckLineItemId),
    code VARCHAR(20),
    message TEXT
);
