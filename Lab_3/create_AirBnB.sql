CREATE DATABASE IF NOT EXISTS AirBnB;
USE AirBnB;

DROP TABLE IF EXISTS response_photo;
DROP TABLE IF EXISTS apartament_response;
DROP TABLE IF EXISTS apartament_photo;
DROP TABLE IF EXISTS apartament_reserved;
DROP TABLE IF EXISTS payment_transaction;
DROP TABLE IF EXISTS response;
DROP TABLE IF EXISTS renter;
DROP TABLE IF EXISTS apartament;
DROP TABLE IF EXISTS lessor;
DROP TABLE IF EXISTS photo;


CREATE TABLE photo
(
    id         INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type       VARCHAR(10) NOT NULL,
    image      BLOB        NOT NULL,
    image_size VARCHAR(20) NULL DEFAULT NULL,
    name       VARCHAR(20) NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE lessor
(
    id           INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(20) NOT NULL,
    surname      VARCHAR(20) NOT NULL,
    last_name    VARCHAR(20) NULL DEFAULT NULL,
    phone_number VARCHAR(15) NOT NULL,
    card_number  VARCHAR(16) NOT NULL,
    contact_info LONGTEXT    NULL DEFAULT NULL,
    photo_id     INT         NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
    INDEX fk_lessor_photo1_idx (photo_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE apartament
(
    id                      INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    area                    DOUBLE        NOT NULL,
    adress                  VARCHAR(60)   NOT NULL,
    ceiling_high            DOUBLE        NULL DEFAULT 2.75,
    room_number             INT           NOT NULL,
    recomended_people_count INT           NULL DEFAULT NULL,
    price                   DECIMAL(7, 2) NOT NULL,
    lessor_id               INT           NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
    UNIQUE INDEX adress_UNIQUE (adress ASC) VISIBLE,
    INDEX fk_apartament_lessor1_idx (lessor_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE renter
(
    id           INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(20) NOT NULL,
    surname      VARCHAR(20) NOT NULL,
    last_name    VARCHAR(20) NULL DEFAULT NULL,
    phone_number VARCHAR(15) NOT NULL,
    card_number  VARCHAR(16) NOT NULL,
    photo_id     INT         NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
    INDEX fk_renter_photo1_idx (photo_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE payment_transaction
(
    id                   INT     NOT NULL AUTO_INCREMENT PRIMARY KEY,
    renter_id            INT     NOT NULL,
    lessor_id            INT     NOT NULL,
    renter_payment       TINYINT NULL DEFAULT NULL,
    lessor_recieve_money TINYINT NULL DEFAULT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
    INDEX fk_payment_transaction_render1_idx (renter_id ASC) VISIBLE,
    INDEX fk_payment_transaction_lessor1_idx (lessor_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE apartament_reserved
(
    id                     INT      NOT NULL AUTO_INCREMENT,
    apartament_id          INT      NOT NULL,
    reserved               TINYINT  NOT NULL,
    wish                   LONGTEXT NULL DEFAULT NULL,
    payment_transaction_id INT      NOT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
    UNIQUE INDEX payment_transaction_id_UNIQUE (payment_transaction_id ASC) VISIBLE,
    INDEX fk_apartament_reserved_apartament_idx (apartament_id ASC) VISIBLE,
    INDEX fk_apartament_reserved_payment_transaction1_idx (payment_transaction_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE response
(
    id     INT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    coment LONGTEXT NULL,
    rate   INT      NULL DEFAULT 0,
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE apartament_response
(
    response_id   INT NOT NULL,
    apartament_id INT NOT NULL,
    PRIMARY KEY (response_id, apartament_id),
    UNIQUE INDEX response_id_UNIQUE (response_id ASC) VISIBLE,
    INDEX fk_apartament_response_response1_idx (response_id ASC) VISIBLE,
    INDEX fk_apartament_response_apartament1_idx (apartament_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE apartament_photo
(
    photo_id      INT NOT NULL,
    apartament_id INT NOT NULL,
    PRIMARY KEY (photo_id, apartament_id),
    UNIQUE INDEX photo_id_UNIQUE (photo_id ASC) VISIBLE,
    INDEX fk_apartament_photo_photo1_idx (photo_id ASC) VISIBLE,
    INDEX fk_apartament_photo_apartament1_idx (apartament_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


CREATE TABLE response_photo
(
    photo_id    INT NOT NULL,
    response_id INT NOT NULL,
    PRIMARY KEY (photo_id, response_id),
    INDEX fk_response_photo_photo1_idx (photo_id ASC) VISIBLE,
    INDEX fk_response_photo_response1_idx (response_id ASC) VISIBLE,
    UNIQUE INDEX photo_id_UNIQUE (photo_id ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 0;


ALTER TABLE apartament
    ADD CONSTRAINT fk_apartament_lessor
        FOREIGN KEY (lessor_id)
            REFERENCES lessor (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE lessor
    ADD CONSTRAINT fk_lessor_photo
        FOREIGN KEY (photo_id)
            REFERENCES photo (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE renter
    ADD CONSTRAINT fk_renter_photo1
        FOREIGN KEY (photo_id)
            REFERENCES photo (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE payment_transaction
    ADD CONSTRAINT fk_payment_transaction_lessor1
        FOREIGN KEY (lessor_id)
            REFERENCES lessor (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    ADD CONSTRAINT fk_payment_transaction_render1
        FOREIGN KEY (renter_id)
            REFERENCES renter (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE apartament_reserved
    ADD CONSTRAINT fk_apartament_reserved_apartament
        FOREIGN KEY (apartament_id)
            REFERENCES apartament (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    ADD CONSTRAINT fk_apartament_reserved_payment_transaction1
        FOREIGN KEY (payment_transaction_id)
            REFERENCES payment_transaction (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE apartament_response
    ADD CONSTRAINT fk_apartament_response_apartament
        FOREIGN KEY (apartament_id)
            REFERENCES apartament (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    ADD CONSTRAINT fk_apartament_response_response
        FOREIGN KEY (response_id)
            REFERENCES response (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE apartament_photo
    ADD CONSTRAINT fk_apartament_photo_apartament1
        FOREIGN KEY (apartament_id)
            REFERENCES apartament (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    ADD CONSTRAINT fk_apartament_photo_photo1
        FOREIGN KEY (photo_id)
            REFERENCES photo (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE response_photo
    ADD CONSTRAINT fk_response_photo_photo1
        FOREIGN KEY (photo_id)
            REFERENCES photo (id),
    ADD CONSTRAINT fk_response_photo_response1
        FOREIGN KEY (response_id)
            REFERENCES response (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;


INSERT INTO photo (type, image, image_size, name)
VALUES ('jpg', '...', '2.1mb', 'sky1'),
       ('jpg', '...', '2.3mb', 'sky1'),
       ('jpg', '...', '1.3mb', 'sky1'),
       ('jpg', '...', '0.9mb', 'sky1'),
       ('jpg', '...', '3.3mb', 'sky1'),
       ('jpg', '...', '4.6mb', 'sky1'),
       ('jpg', '...', '3.8mb', 'sky1'),
       ('jpg', '...', '2.2mb', 'sky1'),
       ('jpg', '...', '3.0mb', 'sky1'),
       ('jpg', '...', '1.7mb', 'sky1'),
       ('jpg', '...', '2.1mb', 'sky1'),
       ('jpg', '...', '1.6mb', 'sky1'),
       ('jpg', '...', '1.3mb', 'sky1'),
       ('jpg', '...', '2.7mb', 'sky1'),
       ('jpg', '...', '2.4mb', 'sky1');

INSERT INTO lessor (name, surname, last_name, phone_number, card_number, contact_info, photo_id)
VALUES ('Carole', 'Duarte', 'Turner', '(228)323-4772', '688322',
        'Keno Quick Pick for the popular game played in many countries', '1'),
       ('Jenna', 'Knights', 'Casey', '(540)438-9816', '390462',
        'Coin Flipper will give you heads or tails in many currencies', '3'),
       ('Lilli', 'Woods', 'Kirk', '(347)825-1403', '785057',
        'Playing Card Shuffler will draw cards from multiple shuffled decks', '4'),
       ('Milli', 'Mccann', 'Brooks', '(302)421-8420', '714990',
        'Step by Step Video shows how to hold a drawing with the Third-Party Draw Service', '6'),
       ('Joel', 'Sadler', 'Wilkerso', '(251)607-1281', '134055',
        'Drawing FAQ answers common questions about holding drawings', '12'),
       ('Maisy', 'Rowe', NULL, '(406)414-8151', '562404',
        'Public Records shows all completed drawings going back five years', '2'),
       ('Malaki', 'Atkinson', NULL, '(304)809-5456', '290800',
        'Drawing Result Widget can be used to publish your winners on your web page', '5'),
       ('Eduardo', 'Greer', 'Elliott', '(786)258-1550', '779930',
        'Decimal Fraction Generator makes numbers in the [0,1] range with configurable decimal places',
        '8'),
       ('Ruby-May', 'Osborne', NULL, '(601)844-4538', '271342',
        'Password Generator makes secure passwords for your Wi-Fi or that extra Gmail account',
        '14'),
       ('Dianne', 'Thompson', NULL, '(619)377-5644', '458881', 'Bitmaps in black and white', '7'),
       ('Carmel', 'Hilton', 'Hale', '(320)745-4778', '375235',
        'Samuel Becketts randomly generated short prose', '9');

INSERT INTO apartament(area, adress, ceiling_high, room_number, recomended_people_count, price,
                       lessor_id)
VALUES ('20', '31 Wagon Street West Babylon, NY 11704', 2, '1', '1', '2500', '11'),
       ('45', '20 Armstrong Ave. Waxhaw, NC 28173', 3, '3', '2', '4500', '1'),
       ('28', '94 E. Glenholme Avenue Clayton, NC 27520', '2.3', '2', '1', '2400', '2'),
       ('50', '9234 West Meadowbrook Lane Aberdeen, SD 57401', '2.5', '3', '4', '5900', '9'),
       ('100', '7774 Mountainview Road Wyoming, MI 49509', '2.7', '5', '6', '12000', '5'),
       ('70', '12 Second St. Fayetteville, NC 28303', '2.75', '4', '5', '8600', '2'),
       ('80', '7115 Selby St. Woburn, MA 01801', '2.8', '4', '4', '9200', '7'),
       ('47', '762 East Thompson Street Alpharetta, GA 30004', '3', '2', '3', '3600', '8'),
       ('90', '410 Cedar Swamp Dr. Huntington Station, NY 11746', '3', '5', '6', '9300', '3'),
       ('72', '9958 Hillcrest Avenue Summerfield, FL 34491', '3', '3', '6', '5300', '2'),
       ('84', '533 Newbridge St. Oakland, CA 94603', '3', '5', '7', '6900', '5'),
       ('120', '166 Eagle Ave. New City, NY 10956', '3', '6', '8', '15600', '4');

INSERT INTO renter(name, surname, last_name, phone_number, card_number, photo_id)
VALUES ('Ryder', 'Wainwright', 'Turner', '(228)323-4772', '4024007190786599', '1'),
       ('Rico', 'Draper', 'Thorpe', '(208)419-7087', '4532672514187033', '3'),
       ('Freddie', 'Ward', null, '(401)350-5010', '2221005050753043', '4'),
       ('Lillie-Rose', 'Fitzpatrick', 'Solis', '(586)755-8695', '36534201828130', '6'),
       ('May', 'Johnston', 'Black', '(414)578-7899', '6763268455435492', '2'),
       ('Usaamah', 'Callaghan', 'Rosales', '(306)822-1279', '6304106231331773', '8'),
       ('Agatha ', 'Bain', 'Wilde', '(425)218-5294', '5505898823941675', '6'),
       ('Carole', 'Thorpe', 'Patton', '(254)288-5804', '5566210302223748', '4'),
       ('Menna', 'Dennis', 'Rosales', '(559)782-2961', '341606419443827', '3'),
       ('Timur', 'Duarte', null, '(424)610-2948', '341979859847629', '2'),
       ('Samirah', 'Lozano', 'Beck', '(213)375-4769', '6391361272597972', '11'),
       ('Hope', 'Carney', 'Waller', '(339)927-8359', '30178983503689', '2'),
       ('Sabrina', 'Bishop', 'Cotton', '(405)728-8742', '4844975059452651', '7');

INSERT INTO payment_transaction(renter_id, lessor_id, renter_payment, lessor_recieve_money)
VALUES (13, 11, 1, 0),
       (3, 5, 0, 0),
       (2, 7, 0, 0),
       (5, 8, 0, 0),
       (6, 5, 0, 0),
       (7, 2, 0, 0),
       (1, 3, 1, 1),
       (13, 10, 1, 0),
       (5, 7, 1, 1),
       (4, 6, 1, 1),
       (3, 8, 0, 0),
       (7, 6, 1, 1),
       (9, 11, 1, 1);

INSERT INTO apartament_reserved(apartament_id, reserved, wish, payment_transaction_id)
VALUES ('1', '1', 'Pure White Audio Noise for composition or just to test your audio equipment',
        '12'),
       ('4', '1', 'Samuel Becketts randomly generated short prose', '11'),
       ('8', '1',
        'Many Testimonials from folks who have found very creative uses for random numbers', '9'),
       ('6', '1', 'Real-Time Statistics show how the generator is performing right now', '2'),
       ('10', '0', 'Your Quota tells how many random bits you have left for today', '1'),
       ('12', '0', '', '10'),
       ('7', '1', 'Newsletter appears at random intervals, but do sign up', '4'),
       ('5', '1', '', '13'),
       ('9', '0', '', '8'),
       ('3', '1', 'Contact Details in case you want to get in touch', '5'),
       ('2', '0', '', '7'),
       ('1', '1', 'Coin Flipper will give you heads or tails in many currencies', '6'),
       ('8', '1', 'Playing Card Shuffler will draw cards from multiple shuffled decks', '3');

INSERT INTO response(coment, rate)
VALUES ('Drawing FAQ answers common questions about holding drawings', 72),
       ('Public Records shows all completed drawings going back five years', null),
       (null, 89),
       ('Lottery Quick Pick is perhaps the Internets most popular with over 280 lotteries', 76),
       ('Playing Card Shuffler will draw cards from multiple shuffled decks', 67),
       ('Price Calculator tells exactly how much your drawing will cost', null),
       ('Sequence Generator will randomize an integer sequence of your choice', 100),
       (null, 56),
       ('Raw Random Bytes are useful for many cryptographic purposes', 34),
       (null, 45);

INSERT INTO apartament_response(response_id, apartament_id)
VALUES (1, 8),
       (2, 7),
       (3, 5),
       (4, 3),
       (5, 2),
       (6, 8),
       (7, 9),
       (8, 10),
       (9, 4),
       (10, 11);

INSERT INTO apartament_photo(photo_id, apartament_id)
VALUES (1, 4),
       (2, 3),
       (3, 7),
       (4, 8),
       (5, 1),
       (6, 9),
       (7, 10),
       (8, 4),
       (9, 4),
       (10, 12),
       (11, 11);

INSERT INTO response_photo(photo_id, response_id)
VALUES (1, 4),
       (2, 3),
       (3, 7),
       (4, 8),
       (5, 1),
       (6, 9),
       (7, 10),
       (8, 4),
       (9, 4),
       (10, 2),
       (11, 7);
    