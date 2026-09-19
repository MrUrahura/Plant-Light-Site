-- KEEP IN CASE OF DATABASE LOSS TO REMAKE IT OR IF SWITCHING TO SQLite3
-- Create the plants table
CREATE TABLE plants (
    id INT PRIMARY KEY,
    name VARCHAR(25),
    type VARCHAR(15),
    min_dli INT,
    max_dli INT
);

-- Insert rows of data into the plants table
INSERT INTO plants (id, name, type, min_dli, max_dli) 
VALUES 
(1, 'African Violets', 'Flower', 4, 14),
(2, 'Aglaonema', 'Flower', 4, 14),
(3, 'Alocasia', 'Flower', 4, 14),
(4, 'Aloe Vera', 'Succulent/Cactus', 4, 14),
(5, 'Amaryllis', 'Flower', 4, 14),
(6, 'Anthurium', 'Flower', 4, 14),
(7, 'Aspidistra', 'Houseplant', 4, 18),
(8, 'Basil', 'Herb', 12, 26),
(9, 'Blackberry', 'Flower', 8, 14),
(10, 'Blueberry', 'Flower', 14, 24),
(11, 'Broccoli', 'Flower', 15, 35),
(12, 'Bromeliad', 'Flower', 4, 14),
(13, 'Cactus', 'Succulent/Cactus', 20, 25),
(14, 'Cannabis (Short-Day Flowering)', 'Flower', 35, 50),
(15, 'Chrysanthemums', 'Flower', 10, 14),
(16, 'Cilantro', 'Herb', 20, 28),
(17, 'Citrus (Various)', 'Herb', 20, 28),
(18, 'Croton', 'Houseplant', 4, 16),
(19, 'Cucumber', 'Neutral-Light Fruiting Vegetable', 20, 30),
(20, 'Culinary Herbs (Small)', 'Herbs', 10, 12),
(21, 'Cyclamen', 'Flower', 6, 8),
(22, 'Desert Cacti', 'Succulent/Cactus', 9, 30),
(23, 'Dill', 'Herb', 20, 28),
(24, 'Dracaena', 'Houseplant', 4, 14),
(25, 'Dragon Tree', 'Houseplant', 4, 14),
(26, 'Dwarf Banana', 'Houseplant', 4, 14),
(27, 'Eggplants', 'Fruiting Vegetable', 20, 30),
(28, 'English Ivy', 'Shade Houseplant', 4, 8),
(29, 'Ferns (Pteridaceae)', 'Shade Houseplant', 4, 6),
(30, 'Ferns (Asplenium)', 'Houseplant', 4, 15),
(31, 'Ficus', 'Houseplant', 6, 12),
(32, 'Fuchsia', 'Flower', 10, 12),
(33, 'Garden Lettuce', 'Leafy Green', 14, 16),
(34, 'Grapefruit', 'Flower', 22, 30),
(35, 'Hibiscus', 'Flower', 4, 14),
(36, 'Hoya', 'Flower', 4, 12),
(37, 'Jasmine', 'Flower', 5, 16),
(38, 'Kalanchoe', 'Flower', 9, 30),
(39, 'Kumquat', 'Flower', 22, 30),
(40, 'Lemon', 'Flower', 21, 28),
(41, 'Lime', 'Flower', 21, 28),
(42, 'Mint', 'Herb', 10, 20),
(43, 'Money Tree', 'Houseplant', 4, 14),
(44, 'Monstera', 'Houseplant', 4, 12),
(45, 'Olive', 'Flower', 18, 40),
(46, 'Orange', 'Flower', 22, 30),
(47, 'Orchids (High-Light)', 'Flower', 8, 18),
(48, 'Orchids (Moderate-Light)', 'Flower', 4, 8),
(49, 'Orchids (Low-Light)', 'Flower', 4, 6),
(50, 'Oregano', 'Herb', 20, 28),
(51, 'Oxalis', 'Flower', 2, 10),
(52, 'Palm Trees', 'Flower', 10, 40),
(53, 'Parsley', 'Herb', 10, 20),
(54, 'Peace Lily', 'Flower', 4, 14),
(55, 'Peach', 'Flower', 8, 14),
(56, 'Peas', 'Neutral-Light Fruiting Vegetable', 9, 12),
(57, 'Peperomia', 'Houseplant', 4, 12),
(58, 'Peppers', 'High-Light Fruiting Vegetable', 20, 30),
(59, 'Petunias', 'Flower', 16, 18),
(60, 'Philodendron', 'Houseplant', 4, 14),
(61, 'Pineapple', 'Flower', 15, 30),
(62, 'Polka Dot Plant', 'Houseplant', 4, 14),
(63, 'Pothos', 'Houseplant', 4, 14),
(64, 'Pumpkins', 'Leafy Green', 12, 15),
(65, 'Radish', 'Neutral-Light Fruiting Vegetable', 18, 28),
(66, 'Rosemary', 'Herb', 20, 28),
(67, 'Roses', 'Flower', 18, 22),
(68, 'Sage', 'Herb', 10, 20),
(69, 'Schefflera', 'Houseplant', 7, 30),
(70, 'Snake Plant', 'Houseplant', 4, 14),
(71, 'Spider Plant', 'Houseplant', 4, 14),
(72, 'Strawberry', 'Flower', 17, 28),
(73, 'Succulents', 'Succulent/Cactus', 3, 6),
(74, 'Syngonium', 'Houseplant', 4, 14),
(75, 'Tangerine', 'Flower', 22, 30),
(76, 'Thyme', 'Herb', 20, 28),
(77, 'Tomatoes', 'High-Light Fruiting Vegetable', 22, 30),
(78, 'Zucchini', 'High-Light Fruiting Vegetable', 22, 28),
(79, 'ZZ Plant', 'Houseplant', 2, 10);

-- Verify the data was added
SELECT * FROM plants;

-- Create the types table
CREATE TABLE types (
    type_name VARCHAR(15) PRIMARY KEY,
    photoperiod INT
);

-- Insert rows of data into the types table
INSERT INTO types (type_name, photoperiod) 
VALUES 
('Flower', 12),
('Shade Houseplant', 12),
('Succulent/Cactus', 14),
('Houseplant', 14),
('Neutral-Light Fruiting Vegetable', 14),
('High-Light Fruiting Vegetable', 16),
('Leafy Green', 16),
('Herb', 16);

-- Verify the data was added
SELECT * FROM types;

-- Create the stages table
CREATE TABLE stages (
    stage_name VARCHAR(15) PRIMARY KEY,
    photoperiod INT
);

-- Insert rows of data into the stages table
INSERT INTO stages (stage_name, photoperiod) 
VALUES 
('Seedling', 18),
('Vegetative', 18),
('Pre-Flowering', 14),
('Short-Day Flowering', 12),
('Long-Day Flowering', 16),
('Fruiting', 12),
('Dormant', 10),
('Germination', 18),
('Mature/Active/Default', null);

-- Verify the data was added
SELECT * FROM stages;