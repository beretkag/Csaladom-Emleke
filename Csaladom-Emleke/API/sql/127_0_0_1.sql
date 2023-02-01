-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Feb 01. 13:17
-- Kiszolgáló verziója: 10.4.6-MariaDB
-- PHP verzió: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `csaladomemleke`
--
CREATE DATABASE IF NOT EXISTS `csaladomemleke` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `csaladomemleke`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `anyak`
--

CREATE TABLE `anyak` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `anyaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `anyak`
--

INSERT INTO `anyak` (`ID`, `csaladtagID`, `anyaID`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `apak`
--

CREATE TABLE `apak` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `apaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `beallitasok`
--

CREATE TABLE `beallitasok` (
  `ID` int(11) NOT NULL,
  `csaladfaID` int(11) NOT NULL,
  `Nev` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `publikus` tinyint(1) NOT NULL,
  `hatterszin` varchar(6) COLLATE utf8_hungarian_ci NOT NULL,
  `alapertelmezettszin` varchar(6) COLLATE utf8_hungarian_ci NOT NULL,
  `noszin` varchar(6) COLLATE utf8_hungarian_ci NOT NULL,
  `ferfiszin` varchar(6) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csaladfak`
--

CREATE TABLE `csaladfak` (
  `ID` int(11) NOT NULL,
  `felhasznaloID` int(11) NOT NULL,
  `alapertelmezett` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csaladfak`
--

INSERT INTO `csaladfak` (`ID`, `felhasznaloID`, `alapertelmezett`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `csaladtagadatok`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `csaladtagadatok` (
`ID` int(11)
,`csaladfaID` int(11)
,`alapertelmezett` tinyint(1)
,`profilkep` varchar(120)
,`telefonszam` varchar(20)
,`Nev` varchar(200)
,`szulhely` varchar(100)
,`szulido` date
,`halhely` varchar(100)
,`halido` date
,`partnerID` int(11)
,`apaID` int(11)
,`anyaID` int(11)
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csaladtagok`
--

CREATE TABLE `csaladtagok` (
  `ID` int(11) NOT NULL,
  `csaladfaID` int(11) NOT NULL,
  `alapertelmezett` tinyint(1) NOT NULL,
  `profilkep` varchar(120) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `telefonszam` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `Nev` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulhely` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulido` date DEFAULT NULL,
  `halhely` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `halido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csaladtagok`
--

INSERT INTO `csaladtagok` (`ID`, `csaladfaID`, `alapertelmezett`, `profilkep`, `telefonszam`, `Nev`, `szulhely`, `szulido`, `halhely`, `halido`) VALUES
(1, 1, 1, NULL, NULL, 'Kovács István', NULL, '1973-07-22', NULL, '1998-05-03'),
(2, 1, 0, NULL, NULL, 'Pék Margit', NULL, '1954-02-03', NULL, '2019-03-18');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `eletut`
--

CREATE TABLE `eletut` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `szoveg` text COLLATE utf8_hungarian_ci DEFAULT NULL,
  `QRlink` varchar(255) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `ID` int(11) NOT NULL,
  `Nev` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `Jelszo` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `jogosultsag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`ID`, `Nev`, `Jelszo`, `email`, `jogosultsag`) VALUES
(1, 'Kovács János', '86f7e437faa5a7fce15d1ddcb9eaeaea377667b8', 'a@a.com', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kepek`
--

CREATE TABLE `kepek` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `Nev` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `partnerek`
--

CREATE TABLE `partnerek` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `partnerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Nézet szerkezete `csaladtagadatok`
--
DROP TABLE IF EXISTS `csaladtagadatok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `csaladtagadatok`  AS  select `csaladtagok`.`ID` AS `ID`,`csaladtagok`.`csaladfaID` AS `csaladfaID`,`csaladtagok`.`alapertelmezett` AS `alapertelmezett`,`csaladtagok`.`profilkep` AS `profilkep`,`csaladtagok`.`telefonszam` AS `telefonszam`,`csaladtagok`.`Nev` AS `Nev`,`csaladtagok`.`szulhely` AS `szulhely`,`csaladtagok`.`szulido` AS `szulido`,`csaladtagok`.`halhely` AS `halhely`,`csaladtagok`.`halido` AS `halido`,`partnerek`.`partnerID` AS `partnerID`,`apak`.`apaID` AS `apaID`,`anyak`.`anyaID` AS `anyaID` from (((`csaladtagok` left join `anyak` on(`anyak`.`csaladtagID` = `csaladtagok`.`ID`)) left join `apak` on(`apak`.`csaladtagID` = `csaladtagok`.`ID`)) left join `partnerek` on(`partnerek`.`csaladtagID` = `csaladtagok`.`ID`)) ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `anyak`
--
ALTER TABLE `anyak`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`);

--
-- A tábla indexei `apak`
--
ALTER TABLE `apak`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`);

--
-- A tábla indexei `beallitasok`
--
ALTER TABLE `beallitasok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladfaID` (`csaladfaID`);

--
-- A tábla indexei `csaladfak`
--
ALTER TABLE `csaladfak`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `felhasznaloID` (`felhasznaloID`);

--
-- A tábla indexei `csaladtagok`
--
ALTER TABLE `csaladtagok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladfaID` (`csaladfaID`);

--
-- A tábla indexei `eletut`
--
ALTER TABLE `eletut`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `kepek`
--
ALTER TABLE `kepek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`);

--
-- A tábla indexei `partnerek`
--
ALTER TABLE `partnerek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `anyak`
--
ALTER TABLE `anyak`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `apak`
--
ALTER TABLE `apak`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `beallitasok`
--
ALTER TABLE `beallitasok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `csaladfak`
--
ALTER TABLE `csaladfak`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `csaladtagok`
--
ALTER TABLE `csaladtagok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `eletut`
--
ALTER TABLE `eletut`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `kepek`
--
ALTER TABLE `kepek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `partnerek`
--
ALTER TABLE `partnerek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `anyak`
--
ALTER TABLE `anyak`
  ADD CONSTRAINT `anyak_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`);

--
-- Megkötések a táblához `apak`
--
ALTER TABLE `apak`
  ADD CONSTRAINT `apak_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`);

--
-- Megkötések a táblához `beallitasok`
--
ALTER TABLE `beallitasok`
  ADD CONSTRAINT `beallitasok_ibfk_1` FOREIGN KEY (`csaladfaID`) REFERENCES `csaladfak` (`ID`);

--
-- Megkötések a táblához `csaladfak`
--
ALTER TABLE `csaladfak`
  ADD CONSTRAINT `csaladfak_ibfk_1` FOREIGN KEY (`felhasznaloID`) REFERENCES `felhasznalok` (`ID`);

--
-- Megkötések a táblához `csaladtagok`
--
ALTER TABLE `csaladtagok`
  ADD CONSTRAINT `csaladtagok_ibfk_1` FOREIGN KEY (`csaladfaID`) REFERENCES `csaladfak` (`ID`);

--
-- Megkötések a táblához `eletut`
--
ALTER TABLE `eletut`
  ADD CONSTRAINT `eletut_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`);

--
-- Megkötések a táblához `kepek`
--
ALTER TABLE `kepek`
  ADD CONSTRAINT `kepek_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`);

--
-- Megkötések a táblához `partnerek`
--
ALTER TABLE `partnerek`
  ADD CONSTRAINT `partnerek_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
