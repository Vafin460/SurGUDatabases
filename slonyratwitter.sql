-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 16 2025 г., 20:27
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
-- Структура таблицы `likes`
--

CREATE TABLE `likes` (
  `postId` int NOT NULL COMMENT 'ID поста',
  `userId` int NOT NULL COMMENT 'ID пользователя',
  `likeType` smallint NOT NULL COMMENT '1 - лайк, -1 дизлайк'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `likes`
--

INSERT INTO `likes` (`postId`, `userId`, `likeType`) VALUES
(0, 1, 1),
(0, 2, 1),
(0, 3, 1),
(1, 1, -1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(1, 5, 1),
(2, 1, 1),
(2, 5, -1),
(5, 1, 1),
(5, 3, 1),
(5, 4, 1),
(5, 5, 1),
(6, 1, 1),
(6, 2, 1),
(6, 3, 1),
(7, 1, 1),
(7, 4, 1),
(9, 1, -1),
(11, 1, -1),
(11, 5, 1),
(12, 1, 1),
(15, 1, 1),
(17, 1, 1),
(18, 1, 1),
(22, 1, -1),
(25, 1, 1),
(26, 1, 1),
(27, 1, 1),
(28, 1, 1),
(30, 1, -1),
(32, 1, -1),
(34, 1, -1),
(36, 1, -1);

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int NOT NULL COMMENT 'ID поста, по нему также идёт сортировка ',
  `postUserId` int NOT NULL COMMENT 'ID пользователя, написавшего пост',
  `postText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Сам пост',
  `postDate` date NOT NULL COMMENT 'Дата написания',
  `parent_id` int NOT NULL COMMENT 'ID родительского поста, если не 0 то рисуется под ним'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `postUserId`, `postText`, `postDate`, `parent_id`) VALUES
(0, 1, 'это так называемая база', '1601-01-01', 0),
(1, 1, 'Hellow World!', '2025-03-01', 0),
(2, 3, 'Hellow World! (2)', '2025-03-09', 1),
(5, 1, 'hehehahah', '2025-02-28', 0),
(6, 1, 'Привет', '2025-03-30', 0),
(7, 1, 'Привет', '2025-03-30', 6),
(8, 1, 'Такие дела', '2025-03-30', 0),
(9, 1, 'Вот такие пироги', '2025-03-30', 0),
(11, 3, 'zxc', '2025-03-30', 0),
(12, 3, 'Хихихахах', '2025-03-30', 0),
(13, 1, 'Хихихахах', '2025-03-30', 12),
(14, 3, 'Хай', '2025-03-30', 12),
(15, 3, 'Хай', '2025-03-30', 0),
(16, 1, 'Хихихахах', '2025-03-30', 0),
(17, 3, 'Хай', '2025-03-30', 0),
(18, 3, 'Привет', '2025-03-30', 0),
(19, 3, 'Привет', '2025-03-30', 18),
(20, 3, 'Чего', '2025-03-30', 0),
(22, 1, 'Хихихахах', '2025-03-30', 0),
(23, 1, '1', '2025-03-30', 0),
(24, 1, '1\n2\n3\n4\n5\n', '2025-03-30', 0),
(25, 5, 'оТЛИЧНО', '2025-03-30', 0),
(26, 5, 'оТЛИЧНО', '2025-03-30', 0),
(27, 1, 'дэмм', '2025-03-30', 0),
(28, 7, 'Пашет почти', '2025-03-30', 0),
(29, 1, 'не почти а пашет\n', '2025-03-30', 0),
(30, 7, 'Нет', '2025-03-30', 0),
(31, 1, 'как нет\n', '2025-03-30', 0),
(32, 7, 'Я через консоль не смог отправить сообщение другого цвета(\n', '2025-03-30', 0),
(33, 1, 'какой другой цвет, у меня sql запросы делаются\n', '2025-03-30', 0),
(34, 7, 'да, можно через инъекцию попробовать задать COLOR тексту', '2025-03-30', 0),
(35, 1, 'много хочешь', '2025-03-30', 0),
(36, 7, 'Осталось купить домен Чебурнет.РФ и на него занести этот сайт\n', '2025-03-30', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL COMMENT 'Идентификатор пользователя',
  `login` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Логин пользователя под которым он будет логинится',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Имя пользователя которое будет отображаться',
  `pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Пароль пользователя'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица пользователей';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `name`, `pass`) VALUES
(1, 'admin', 'Vadim Vafin', 'zxc'),
(2, 'neAdmin', 'Валера', 'zxc'),
(3, 'vvv', 'Влад', 'zxc'),
(4, 'ИТ', 'ИТ', 'ППП'),
(5, '123', '123', '123'),
(6, 'vadim vafin', 'gg', '123'),
(7, 'Reshala', 'Сергей', 'TheCoolPassword12!'),
(8, '111', '111', '111'),
(9, '333', 'kto-to', 'zxc'),
(11, '444', '444', '444'),
(12, 'student', 'Vadim', 'veryHardPassword');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`postId`,`userId`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `postUserId` (`postUserId`),
  ADD KEY `id` (`id`),
  ADD KEY `parent_id_index` (`parent_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usId` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID поста, по нему также идёт сортировка ', AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор пользователя', AUTO_INCREMENT=13;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`postUserId`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
