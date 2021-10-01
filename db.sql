-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Окт 1 2021 г., 21:18
-- Версия сервера: 10.4.8-MariaDB
-- Версия PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Classes`
--

-- --------------------------------------------------------

--
-- Структура таблицы `schedule`
--

CREATE TABLE `schedule` (
  `ID` int(5) NOT NULL,
  `Teacher` int(5) NOT NULL,
  `Subject` int(5) NOT NULL,
  `Day` varchar(15) NOT NULL,
  `classroom` varchar(10) NOT NULL,
  `Quantity` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `schedule`
--

INSERT INTO `schedule` (`ID`, `Teacher`, `Subject`, `Day`, `classroom`, `Quantity`) VALUES
(1, 1, 1, 'Понедельник', 'Д-501', 44),
(2, 2, 2, 'Понедельник', 'Д-320', 40),
(3, 3, 3, 'Понедельник', 'A-509', 34),
(4, 4, 4, 'Вторник', 'Д-417', 35),
(5, 5, 7, 'Вторник', 'Д-417', 10),
(6, 4, 5, 'Среда', 'Д-503', 15),
(7, 6, 6, 'Среда', 'Д-518', 60),
(8, 3, 3, 'Среда', 'А-509', 40),
(9, 2, 2, 'Четверг', 'Д-616', 44),
(10, 4, 5, 'Четверг', 'Д-521', 35),
(11, 1, 1, 'Пятница', 'Д-505', 30),
(12, 3, 3, 'Пятница', 'Д-518', 29),
(13, 5, 7, 'Пятница', 'Д-417', 15),
(14, 8, 7, 'Суббота', 'Д-501', 20),
(15, 7, 8, 'Суббота', 'Д-501', 30);

-- --------------------------------------------------------

--
-- Структура таблицы `subjects`
--

CREATE TABLE `subjects` (
  `ID` int(5) NOT NULL,
  `Name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `subjects`
--

INSERT INTO `subjects` (`ID`, `Name`) VALUES
(1, 'Архитектура вычислительных систем'),
(2, 'Психология и педагогика'),
(3, 'Тестирование ПО'),
(4, 'Надежность ПО'),
(5, 'Теория принятия решений'),
(6, 'Основы управленческой деятельности'),
(7, 'Разработка защищенных программных систем'),
(8, 'Конструирование ПО');

-- --------------------------------------------------------

--
-- Структура таблицы `teachers`
--

CREATE TABLE `teachers` (
  `ID` int(11) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Patronymic` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `teachers`
--

INSERT INTO `teachers` (`ID`, `Surname`, `Name`, `Patronymic`) VALUES
(1, 'Кашковский', 'Виктор', 'Владимирович'),
(2, 'Сергеева', 'Ирина', 'Альбертовна'),
(3, 'Лучников', 'Владимир', 'Александрович'),
(4, 'Ермаков', 'Анатолий', 'Анатольевич'),
(5, 'Краковский', 'Юрий', 'Мечеславович'),
(6, 'Кириллова', 'Татьяна', 'Клементьевна'),
(7, 'Курганская', 'Ольга', 'Викторовна'),
(8, 'Костенко', 'Мария', 'Сегреевна');
--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Teacher` (`Teacher`),
  ADD KEY `Subject` (`Subject`);

--
-- Индексы таблицы `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `schedule`
--
ALTER TABLE `schedule`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT для таблицы `subjects`
--
ALTER TABLE `subjects`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `teachers`
--
ALTER TABLE `teachers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`Teacher`) REFERENCES `teachers` (`ID`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`Subject`) REFERENCES `subjects` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;