-- phpMyAdmin SQL Dump
-- version 4.2.12deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 25, 2015 at 08:54 PM
-- Server version: 5.5.43-0+deb8u1
-- PHP Version: 5.6.7-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `HOAManagement`
--

-- --------------------------------------------------------

--
-- Table structure for table `Ownership`
--

CREATE TABLE IF NOT EXISTS `Ownership` (
  `UserID` varchar(256) NOT NULL,
  `PropertyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Property`
--

CREATE TABLE IF NOT EXISTS `Property` (
`ID` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Ticket`
--

CREATE TABLE IF NOT EXISTS `Ticket` (
`ID` int(11) NOT NULL,
  `Title` varchar(256) NOT NULL,
  `Description` text NOT NULL,
  `Status` enum('New','Resolved','Closed','Investigate','Block','InProgress') NOT NULL DEFAULT 'New',
  `AssignedTo` varchar(256) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ResolvedDate` datetime DEFAULT NULL,
  `ClosedDate` datetime DEFAULT NULL,
  `LastModified` datetime NOT NULL,
  `PropertyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `ID` varchar(256) NOT NULL,
  `Token` varchar(256) NOT NULL,
  `FriendlyName` varchar(256) DEFAULT NULL,
  `Role` enum('HomeOwner','BoardMember','Admin','Vendor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Ownership`
--
ALTER TABLE `Ownership`
 ADD KEY `PropertyID` (`PropertyID`), ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `Property`
--
ALTER TABLE `Property`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Ticket`
--
ALTER TABLE `Ticket`
 ADD PRIMARY KEY (`ID`), ADD KEY `AssignedTo` (`AssignedTo`), ADD KEY `PropertyID` (`PropertyID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
 ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Property`
--
ALTER TABLE `Property`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Ticket`
--
ALTER TABLE `Ticket`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
