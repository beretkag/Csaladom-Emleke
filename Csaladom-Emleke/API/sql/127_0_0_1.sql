-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Már 12. 22:20
-- Kiszolgáló verziója: 10.4.25-MariaDB
-- PHP verzió: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Tábla szerkezet ehhez a táblához `beallitasok`
--

CREATE TABLE `beallitasok` (
  `ID` int(11) NOT NULL,
  `csaladfaID` int(11) NOT NULL,
  `publikus` tinyint(1) NOT NULL,
  `hatterszin` varchar(6) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `noszin` varchar(6) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `ferfiszin` varchar(6) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `beallitasok`
--

INSERT INTO `beallitasok` (`ID`, `csaladfaID`, `publikus`, `hatterszin`, `noszin`, `ferfiszin`) VALUES
(1, 5, 1, NULL, NULL, NULL);

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
(5, 6, 1, 'Gellért Beretka');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csaladtagok`
--

CREATE TABLE `csaladtagok` (
  `ID` int(11) NOT NULL,
  `csaladfaID` int(11) NOT NULL,
  `belsofaID` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  `profilkep` varchar(120) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `telefonszam` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `keresztnev` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `vezeteknev` varchar(200) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulhely` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szulido` date DEFAULT NULL,
  `halido` date DEFAULT NULL,
  `mid` varchar(10) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `fid` varchar(10) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `partnerek` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csaladtagok`
--

INSERT INTO `csaladtagok` (`ID`, `csaladfaID`, `belsofaID`, `profilkep`, `telefonszam`, `keresztnev`, `vezeteknev`, `gender`, `szulhely`, `szulido`, `halido`, `mid`, `fid`, `partnerek`) VALUES
(4, 5, 'gfhd', NULL, NULL, 'Gellért', 'Beretka', 'male', NULL, '1999-08-23', NULL, '_uq02', '_3ru7', '_jnm7'),
(8, 5, '_uq02', NULL, NULL, 'Zsuzsanna', 'Bíró', 'female', NULL, NULL, NULL, NULL, NULL, NULL),
(70, 5, '_9zg2', NULL, NULL, NULL, NULL, 'male', NULL, NULL, NULL, '_jnm7', 'gfhd', NULL),
(71, 5, '_jnm7', NULL, NULL, NULL, NULL, 'female', NULL, NULL, NULL, NULL, NULL, 'gfhd');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `eletut`
--

CREATE TABLE `eletut` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `cim` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szoveg` text COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `eletut`
--

INSERT INTO `eletut` (`ID`, `csaladtagID`, `cim`, `szoveg`) VALUES
(4, 71, NULL, NULL);

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
(6, 'Gellért Beretka', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin@admin.com', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kepek`
--

CREATE TABLE `kepek` (
  `ID` int(11) NOT NULL,
  `csaladtagID` int(11) NOT NULL,
  `Nev` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

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
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `beallitasok`
--
ALTER TABLE `beallitasok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `csaladfak`
--
ALTER TABLE `csaladfak`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT a táblához `csaladtagok`
--
ALTER TABLE `csaladtagok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT a táblához `eletut`
--
ALTER TABLE `eletut`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT a táblához `kepek`
--
ALTER TABLE `kepek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- Megkötések a kiírt táblákhoz
--

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
