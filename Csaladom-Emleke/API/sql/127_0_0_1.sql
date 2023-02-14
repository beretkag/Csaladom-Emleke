-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Feb 14. 09:29
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
  `belsofaID` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `anyaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `apak`
--

CREATE TABLE `apak` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `belsofaID` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
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
  `alapertelmezett` tinyint(1) NOT NULL,
  `Nev` varchar(40) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csaladfak`
--

INSERT INTO `csaladfak` (`ID`, `felhasznaloID`, `alapertelmezett`, `Nev`) VALUES
(7, 8, 0, 'Gellért Beretka');

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
,`gender` varchar(20)
,`keresztnev` varchar(200)
,`vezeteknev` varchar(200)
,`szulhely` varchar(100)
,`szulido` date
,`halido` date
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
  `belsofaID` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `alapertelmezett` tinyint(1) NOT NULL,
  `profilkep` varchar(120) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `telefonszam` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `keresztnev` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `vezeteknev` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulhely` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulido` date DEFAULT NULL,
  `halido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csaladtagok`
--

INSERT INTO `csaladtagok` (`ID`, `csaladfaID`, `belsofaID`, `alapertelmezett`, `profilkep`, `telefonszam`, `keresztnev`, `vezeteknev`, `gender`, `szulhely`, `szulido`, `halido`) VALUES
(5, 7, 'aaaa', 0, NULL, NULL, 'Gellért', 'Beretka', 'male', NULL, '1999-07-23', NULL);

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
  `Jelszo` varchar(64) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `jogosultsag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`ID`, `Nev`, `Jelszo`, `email`, `jogosultsag`) VALUES
(8, 'Gellért Beretka', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin@admin.com', 1);

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
  `belsofaID` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `partnerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Nézet szerkezete `csaladtagadatok`
--
DROP TABLE IF EXISTS `csaladtagadatok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `csaladtagadatok`  AS  select `csaladtagok`.`ID` AS `ID`,`csaladtagok`.`csaladfaID` AS `csaladfaID`,`csaladtagok`.`alapertelmezett` AS `alapertelmezett`,`csaladtagok`.`profilkep` AS `profilkep`,`csaladtagok`.`telefonszam` AS `telefonszam`,`csaladtagok`.`gender` AS `gender`,`csaladtagok`.`keresztnev` AS `keresztnev`,`csaladtagok`.`vezeteknev` AS `vezeteknev`,`csaladtagok`.`szulhely` AS `szulhely`,`csaladtagok`.`szulido` AS `szulido`,`csaladtagok`.`halido` AS `halido`,`apak`.`apaID` AS `apaID`,`anyak`.`anyaID` AS `anyaID` from ((`csaladtagok` left join `anyak` on(`anyak`.`csaladtagID` = `csaladtagok`.`ID`)) left join `apak` on(`apak`.`csaladtagID` = `csaladtagok`.`ID`)) ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `anyak`
--
ALTER TABLE `anyak`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`),
  ADD KEY `belsofaID` (`belsofaID`);

--
-- A tábla indexei `apak`
--
ALTER TABLE `apak`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `csaladtagID` (`csaladtagID`),
  ADD KEY `belsofaID` (`belsofaID`);

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
  ADD KEY `csaladfaID` (`csaladfaID`),
  ADD KEY `belsofaID` (`belsofaID`);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `csaladtagok`
--
ALTER TABLE `csaladtagok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `eletut`
--
ALTER TABLE `eletut`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  ADD CONSTRAINT `anyak_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`),
  ADD CONSTRAINT `anyak_ibfk_2` FOREIGN KEY (`belsofaID`) REFERENCES `csaladtagok` (`belsofaID`);

--
-- Megkötések a táblához `apak`
--
ALTER TABLE `apak`
  ADD CONSTRAINT `apak_ibfk_1` FOREIGN KEY (`csaladtagID`) REFERENCES `csaladtagok` (`ID`),
  ADD CONSTRAINT `apak_ibfk_2` FOREIGN KEY (`belsofaID`) REFERENCES `csaladtagok` (`belsofaID`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
