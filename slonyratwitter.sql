-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 31 2025 г., 06:11
-- Версия сервера: 8.0.24
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `slonyratwitter`
--

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `postId` int NOT NULL COMMENT 'ID поста, по нему также идёт сортировка ',
  `postUserId` int NOT NULL COMMENT 'ID пользователя, написавшего пост',
  `postText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Сам пост',
  `postDate` date NOT NULL COMMENT 'Дата написания'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`postId`, `postUserId`, `postText`, `postDate`) VALUES
(1, 1, 'Hellow World!', '2025-03-01'),
(2, 1, 'Hellow World! (2)', '2025-03-09'),
(5, 1, 'hehehahah', '2025-02-28'),
(6, 1, 'Привет', '2025-03-30'),
(7, 1, 'Привет', '2025-03-30'),
(8, 1, 'Такие дела', '2025-03-30'),
(9, 1, 'Вот такие пироги', '2025-03-30'),
(11, 3, 'zxc', '2025-03-30'),
(12, 3, 'Хихихахах', '2025-03-30'),
(13, 1, 'Хихихахах', '2025-03-30'),
(14, 3, 'Хай', '2025-03-30'),
(15, 3, 'Хай', '2025-03-30'),
(16, 1, 'Хихихахах', '2025-03-30'),
(17, 3, 'Хай', '2025-03-30'),
(18, 3, 'Привет', '2025-03-30'),
(19, 3, 'Привет', '2025-03-30'),
(20, 3, 'Чего', '2025-03-30'),
(22, 1, 'Хихихахах', '2025-03-30'),
(23, 1, '1', '2025-03-30'),
(24, 1, '1\n2\n3\n4\n5\n', '2025-03-30'),
(25, 5, 'оТЛИЧНО', '2025-03-30'),
(26, 5, 'оТЛИЧНО', '2025-03-30'),
(27, 1, 'дэмм', '2025-03-30'),
(28, 7, 'Пашет почти', '2025-03-30'),
(29, 1, 'не почти а пашет\n', '2025-03-30'),
(30, 7, 'Нет', '2025-03-30'),
(31, 1, 'как нет\n', '2025-03-30'),
(32, 7, 'Я через консоль не смог отправить сообщение другого цвета(\n', '2025-03-30'),
(33, 1, 'какой другой цвет, у меня sql запросы делаются\n', '2025-03-30'),
(34, 7, 'да, можно через инъекцию попробовать задать COLOR тексту', '2025-03-30'),
(35, 1, 'много хочешь', '2025-03-30'),
(36, 7, 'Осталось купить домен Чебурнет.РФ и на него занести этот сайт\n', '2025-03-30');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `usId` int NOT NULL COMMENT 'Идентификатор пользователя',
  `usLogin` varchar(155) NOT NULL COMMENT 'Логин пользователя под которым он будет логинится',
  `usName` varchar(255) NOT NULL COMMENT 'Имя пользователя которое будет отображаться',
  `usPass` varchar(255) NOT NULL COMMENT 'Пароль пользователя'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица пользователей';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`usId`, `usLogin`, `usName`, `usPass`) VALUES
(1, 'admin', 'Vadim Vafin', 'zxc'),
(2, 'neAdmin', 'Валера', 'zxc'),
(3, 'vvv', 'Влад', 'zxc'),
(4, 'ИТ', 'ИТ', 'ППП'),
(5, '123', '123', '123'),
(6, 'vadim vafin', 'gg', '123'),
(7, 'Reshala', 'Сергей', 'TheCoolPassword12!');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`postId`),
  ADD KEY `postUserId` (`postUserId`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`usId`),
  ADD KEY `usId` (`usId`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `postId` int NOT NULL AUTO_INCREMENT COMMENT 'ID поста, по нему также идёт сортировка ', AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `usId` int NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор пользователя', AUTO_INCREMENT=8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`postUserId`) REFERENCES `users` (`usId`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
