-- Create the cat table
CREATE TABLE IF NOT EXISTS cat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    picture VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the resume table
CREATE TABLE IF NOT EXISTS resume (
    id INT AUTO_INCREMENT PRIMARY KEY,
    version VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the profile table
CREATE TABLE IF NOT EXISTS profile (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    picture VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the achievement table
CREATE TABLE IF NOT EXISTS achievement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    picture VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into the cat table
INSERT INTO cat (name, picture) VALUES
('cat1', './cat/cat1.jpg'),
('Cat2', './cat/cat2.jpg');

-- Insert sample data into the resume table
INSERT INTO resume (version, filename) VALUES
('V1', './resume/resume1.txt'),
('V2', './resume/resume2.txt');

-- Insert sample data into the profile table
INSERT INTO profile (name, picture) VALUES
('Tom', './profile/profile1.png'),
('Jerry', './profile/profile2.png');

-- Insert sample data into the achievement table
INSERT INTO achievement (name, picture) VALUES
('achievement one', './achievement/achievement1.png'),
('achievement two', './achievement/achievement2.png');
