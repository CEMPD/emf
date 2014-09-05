DROP TABLE reference.control_device;

CREATE TABLE reference.control_device (
control_device_code integer,
control_device_desc varchar(128),
valid_v20 varchar(1),
valid_v30 varchar(1),
last_mod_date timestamp without time zone,
pollutants varchar(128),
comments varchar(128)
);

INSERT INTO reference.control_device VALUES
(0,'UNCONTROLLED','Y','Y',null,null,null),
(1,'WET SCRUBBER - HIGH EFFICIENCY','Y','Y',null,null,null),
(2,'WET SCRUBBER - MEDIUM EFFICIENCY','Y','Y',null,null,null),
(3,'WET SCRUBBER - LOW EFFICIENCY','Y','Y',null,null,null),
(4,'GRAVITY COLLECTOR - HIGH EFFICIENCY','Y','Y',null,null,null),
(5,'GRAVITY COLLECTOR - MEDIUM EFFICIENCY','Y','Y',null,null,null),
(6,'GRAVITY COLLECTOR - LOW EFFICIENCY','Y','Y',null,null,null),
(7,'CENTRIFUGAL COLLECTOR (CYCLONE) - HIGH EFFICIENCY','Y','Y',null,null,null),
(8,'CENTRIFUGAL COLLECTOR (CYCLONE) - MEDIUM EFFICIENCY','Y','Y',null,null,null),
(9,'CENTRIFUGAL COLLECTOR (CYCLONE) - LOW EFFICIENCY','Y','Y',null,null,null),
(10,'ELECTROSTATIC PRECIPITATOR - HIGH EFFICIENCY','Y','Y',null,null,null),
(11,'ELECTROSTATIC PRECIPITATOR - MEDIUM EFFICIENCY','Y','Y',null,null,null),
(12,'ELECTROSTATIC PRECIPITATOR - LOW EFFICIENCY','Y','Y',null,null,null),
(13,'GAS SCRUBBER (GENERAL, NOT CLASSIFIED)','Y','Y',null,null,null),
(14,'MIST ELIMINATOR - HIGH VELOCITY, I.E. V>250 FT/MIN','Y','Y',null,null,null),
(15,'MIST ELIMINATOR - LOW VELOCITY, I.E. V<250 FT/MIN','Y','Y',null,null,null),
(16,'FABRIC FILTER - HIGH TEMPERATURE, I.E. T>250F','Y','Y',null,null,null),
(17,'FABRIC FILTER - MEDIUM TEMPERATURE, I.E. 180F<T<250F','Y','Y',null,null,null),
(18,'FABRIC FILTER - LOW TEMPERATURE, I.E. T<180F','Y','Y',null,null,null),
(19,'CATALYTIC AFTERBURNER','Y','Y',null,null,null),
(20,'CATALYTIC AFTERBURNER WITH HEAT EXCHANGER','Y','Y',null,null,null),
(21,'DIRECT FLAME AFTERBURNER','Y','Y',null,null,null),
(22,'DIRECT FLAME AFTERBURNER WITH HEAT EXCHANGER','Y','Y',null,null,null),
(23,'FLARING','Y','Y',null,null,null),
(24,'MODIFIED FURNACE OR BURNER DESIGN','Y','Y',null,null,'NOX'),
(25,'STAGED COMBUSTION','Y','Y',null,null,'NOX'),
(26,'FLUE GAS RECIRCULATION','Y','Y',null,null,'NOX'),
(27,'REDUCED COMBUSTION - AIR PREHEATING','Y','Y',null,null,'NOX'),
(28,'STEAM OR WATER INJECTION','Y','Y',null,null,null),
(29,'LOW EXCESS AIR FIRING','Y','Y',null,null,'NOX'),
(30,'USE OF FUEL WITH LOW NITROGEN CONTENT','Y','Y',null,null,null),
(31,'AIR INJECTION','Y','Y',null,null,'NOX,HC'),
(32,'AMMONIA INJECTION','Y','Y',null,null,'NOX,PM25-PRI,PM10-PRI'),
(33,'CONTROL OF % O2 IN COMBUSTION AIR (OFF STOICHIOMETRIC FIRING)','Y','Y',null,null,'NOX'),
(34,'WELLMAN-LORD/SODIUM SULFITE SCRUBBING','Y','Y',null,null,null),
(35,'MAGNESIUM OXIDE SCRUBBING','Y','Y',null,null,null),
(36,'DUAL ALKALI SCRUBBING','Y','Y',null,null,null),
(37,'CITRATE PROCESS SCRUBBING','Y','Y',null,null,null),
(38,'AMMONIA SCRUBBING','Y','Y',null,null,null),
(39,'CATALYTIC OXIDATION - FLUE GAS DESULFURIZATION','Y','Y',null,null,null),
(40,'ALKALIZED ALUMINA','Y','Y',null,null,null),
(41,'DRY LIMESTONE INJECTION','Y','Y',null,null,null),
(42,'WET LIMESTONE INJECTION','Y','Y',null,null,null),
(43,'SULFURIC ACID PLANT - CONTACT PROCESS','Y','Y',null,null,null),
(44,'SULFURIC ACID PLANT - DOUBLE CONTACT PROCESS','Y','Y',null,null,null),
(45,'SULFUR PLANT','Y','Y',null,null,null),
(46,'PROCESS CHANGE','Y','Y',null,null,null),
(47,'VAPOR RECOVERY SYS (INCL. CONDENSERS, HOODING, OTHER ENCLOSURES)','Y','Y',null,null,null),
(48,'ACTIVATED CARBON ADSORPTION','Y','Y',null,null,null),
(49,'LIQUID FILTRATION SYSTEM','Y','Y',null,null,null),
(50,'PACKED-GAS ABSORPTION COLUMN','Y','Y',null,null,null),
(51,'TRAY-TYPE GAS ABSORPTION COLUMN','Y','Y',null,null,null),
(52,'SPRAY TOWER','Y','Y',null,null,null),
(53,'VENTURI SCRUBBER','Y','Y',null,null,null),
(54,'PROCESS ENCLOSED','Y','Y',null,null,null),
(55,'IMPINGEMENT PLATE SCRUBBER','Y','Y',null,null,null),
(56,'DYNAMIC SEPARATOR (DRY)','Y','Y',null,null,null),
(57,'DYNAMIC SEPARATOR (WET)','Y','Y',null,null,null),
(58,'MAT OR PANEL FILTER','Y','Y',null,null,null),
(59,'METAL FABRIC FILTER SCREEN (COTTON GINS)','Y','Y',null,null,null),
(60,'PROCESS GAS RECOVERY','Y','Y',null,null,null),
(61,'DUST SUPPRESSION BY WATER SPRAYS','Y','Y',null,null,null),
(62,'DUST SUPPRESSION BY CHEMICAL STABILIZERS OR WETTING AGENTS','Y','Y',null,null,null),
(63,'GRAVEL BED FILTER','Y','Y',null,null,null),
(64,'ANNULAR RING FILTER','Y','Y',null,null,null),
(65,'CATALYTIC REDUCTION','Y','Y',null,null,'SO2,NOX'),
(66,'MOLECULAR SIEVE','Y','Y',null,null,null),
(67,'WET LIME SLURRY SCRUBBING','Y','Y',null,null,null),
(68,'ALKALINE FLY ASH SCRUBBING','Y','Y',null,null,null),
(69,'SODIUM CARBONATE SCRUBBING','Y','Y',null,null,null),
(70,'SODIUM-ALKALI SCRUBBING','Y','Y',null,null,null),
(71,'FLUID BED DRY SCRUBBER','Y','Y',null,null,null),
(72,'TUBE AND SHELL CONDENSER','Y','Y',null,null,null),
(73,'REFRIGERATED CONDENSER','Y','Y',null,null,null),
(74,'BAROMETRIC CONDENSER','Y','Y',null,null,null),
(75,'SINGLE CYCLONE','Y','Y',null,null,null),
(76,'MULTIPLE CYCLONE W/O FLY ASH REINJECTION','Y','Y',null,null,null),
(77,'MULTIPLE CYCLONE W/ FLY ASH REINJECTION','Y','Y',null,null,null),
(78,'BAFFLE','Y','Y',null,null,null),
(79,'DRY ELECTROSTATIC GRANULAR FILTER (DEGF)','Y','Y',null,null,null),
(80,'CHEMICAL OXIDATION','Y','Y',null,null,null),
(81,'CHEMICAL REDUCTION','Y','Y',null,null,null),
(82,'OZONATION','Y','Y',null,null,null),
(83,'CHEMICAL NEUTRALIZATION','Y','Y',null,null,'NOX'),
(84,'ACTIVATED CLAY ADSORPTION','Y','Y',null,null,null),
(85,'WET CYCLONIC SEPARATOR','Y','Y',null,null,null),
(86,'WATER CURTAIN','Y','Y',null,null,null),
(87,'NITROGEN BLANKET','Y','Y',null,null,null),
(88,'CONSERVATION VENT','Y','Y',null,null,null),
(89,'BOTTOM FILLING','Y','Y',null,null,null),
(90,'CONVERSION TO VARIABLE VAPOR SPACE TANK','Y','Y',null,null,null),
(91,'CONVERSION TO FLOATING ROOF TANK','Y','Y',null,null,null),
(92,'CONVERSION TO PRESSURIZED TANK','Y','Y',null,null,null),
(93,'SUBMERGED FILLING','Y','Y',null,null,null),
(94,'UNDERGROUND TANK','Y','Y',null,null,null),
(95,'WHITE PAINT','Y','Y',null,null,null),
(96,'VAPOR LOCK BALANCE RECOVERY SYSTEM','Y','Y',null,null,null),
(97,'INSTALLATION OF SECONDARY SEAL FOR EXTERNAL FLOATING ROOF TANK','Y','Y',null,null,null),
(98,'MOVING BED DRY SCRUBBER','Y','Y',null,null,null),
(99,'MISCELLANEOUS CONTROL DEVICES','Y','Y',null,null,'Any'),
(100,'BAGHOUSE','Y','Y',null,null,null),
(101,'HIGH-EFFICIENCY PARTICULATE AIR FILTER (HEPA)','Y','Y',null,null,null),
(102,'LOW SOLVENT COATINGS','Y','Y',null,null,null),
(103,'POWDER COATINGS','Y','Y',null,null,null),
(104,'WATERBORNE COATINGS','Y','Y',null,null,null),
(105,'PROCESS MODIFICATION - ELECTROSTATIC SPRAYING','Y','Y',null,null,null),
(106,'DUST SUPPRESSION BY PHYSICAL STABILIZATION','Y','Y',null,null,null),
(107,'SELECTIVE NONCATALYTIC REDUCTION FOR NOX','Y','Y',null,null,null),
(108,'DUST SUPPRESSION - TRAFFIC CONTROL','Y','Y',null,null,null),
(109,'CATALYTIC OXIDIZER','Y','Y',null,null,null),
(110,'VAPOR RECOVERY UNIT','Y','Y',null,null,null),
(112,'AFTERBURNER','Y','Y',null,null,null),
(113,'ROTOCLONE','Y','Y',null,null,null),
(115,'IMPINGEMENT TYPE WET SCRUBBER','Y','Y',null,null,null),
(116,'CATALYTIC INCINERATOR','Y','Y',null,null,null),
(117,'PACKED SCRUBBER','Y','Y',null,null,null),
(118,'CROSSFLOW PACKED BED','Y','Y',null,null,null),
(119,'DRY SCRUBBER','Y','Y',null,null,null),
(120,'FLOATING BED SCRUBBER','Y','Y',null,null,null),
(121,'MULTIPLE CYCLONES','Y','Y',null,null,null),
(122,'QUENCH TOWER','Y','Y',null,null,null),
(123,'SPRAY SCRUBBER','Y','Y',null,null,null),
(124,'HIGH PRESSURE SCRUBBER','Y','Y',null,null,null),
(125,'LOW PRESSURE SCRUBBER','Y','Y',null,null,null),
(127,'FABRIC FILTER','Y','Y',null,null,null),
(128,'ELECTROSTATIC PRECIPITATOR','Y','Y',null,null,null),
(129,'SCRUBBER','Y','Y',null,null,'PM25-PRI,PM10-PRI,SO2,NOX,VOC'),
(130,'CAUSTIC SCRUBBER','Y','Y',null,null,null),
(131,'THERMAL OXIDIZER','Y','Y',null,null,null),
(132,'CONDENSER','Y','Y',null,null,null),
(133,'INCINERATOR','Y','Y',null,null,null),
(134,'DEMISTER','Y','Y',null,null,null),
(137,'HVAF','Y','Y',null,null,null),
(138,'BOILER AT LANDFILL','Y','Y',null,null,null),
(139,'SCR (SELECTIVE CATALYTIC REDUCTION)','Y','Y',null,null,'NOX'),
(140,'NSCR (NON-SELECTIVE CATALYTIC REDUCTION)','Y','Y',null,null,'NOX'),
(141,'WET SCRUBBER','Y','Y',null,null,null),
(143,'WET SUPPRESSION','Y','Y',null,null,null),
(144,'SPRAY SCREEN','Y','Y',null,null,null),
(145,'SINGLE WET CAP','Y','Y',null,null,null),
(146,'WET ELECTROSTATIC PRECIPITATOR','Y','Y',null,null,null),
(147,'INCREASED AIR/FUEL RATIO WITH INTERCOOLING','Y','Y',null,null,'NOX'),
(148,'CLEAN BURN','Y','Y',null,null,null),
(149,'PRE-COMBUSTION CHAMBER','Y','Y',null,null,null),
(150,'MECHANICAL COLLECTOR','Y','Y',null,null,null),
(151,'FIBER MIST ELIMINATOR','Y','Y',null,null,null),
(152,'MIST ELIMINATOR - HIGH EFFICIENCY','Y','Y',null,null,null),
(153,'WATER SPRAYS','Y','Y',null,null,null),
(154,'SCREENED DRUMS OR CAGES','Y','Y',null,null,null),
(155,'PACKED BED SCRUBBER - HIGH EFFICIENCY','Y','Y',null,null,null),
(157,'SCREEN','Y','Y',null,null,null),
(158,'IONIZING WET SCRUBBER','Y','Y',null,null,null),
(159,'ELECTRIFIED FILTER BED','Y','Y',null,null,null),
(201,'KNOCK OUT BOX','Y','Y',null,null,null),
(202,'SPRAY DRYER','Y','Y',null,null,null),
(203,'CATALYTIC CONVERTER','Y','Y',null,null,'VOC,NOX,SO2,CO'),
(204,'OVERFIRE AIR','Y','Y',null,null,'NOX'),
(205,'LOW NOX BURNERS','Y','Y',null,null,'NOX'),
(206,'DRY SORBENT INJECTION','Y','Y',null,null,null),
(207,'CARBON INJECTION','Y','Y',null,null,null),
(208,'FREEBOARD REFRIGERATION DEVICE','Y','Y',null,null,null),
(212,'STEAM INJECTION',null,null,'2014-08-01',null,'NOX'),
(213,'WATER INJECTION',null,null,'2014-08-01',null,'NOX'),
(214,'LOW NITROGEN CONTENT FUEL',null,null,'2014-08-01',null,'NOX'),
(219,'FREQUENT MONITORING OF CONTROLS',null,null,'2014-08-01',null,'Any'),
(300,'ACID GAS INJECTION','N','Y','2005-06-14','Added 6/14/05 per request NM.',null),
(303,'CATALYTIC ADDITIVES',null,null,'2014-08-01',null,'NOX,SO2'),
(310,'NON-SELECTIVE CATALYTIC REDUCTION (NSCR)',null,null,'2014-08-01',null,'NOX'),
(311,'OTHER POLLUTION PREVENTION TECHNIQUE',null,null,'2014-08-01',null,'Any'),
(316,'ULTRA LOW NOX BURNERS (ULNB)',null,null,'2014-08-01',null,'NOX');