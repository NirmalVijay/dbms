-- Create the database
CREATE DATABASE handball_league;
USE handball_league;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create admins table
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create teams table
CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    coach VARCHAR(100) NOT NULL,
    coach_phone VARCHAR(20) NOT NULL,
    home_ground VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create players table
CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    jersey_number INT NOT NULL,
    goals INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

-- Create matches table
CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,
    home_score INT DEFAULT 0,
    away_score INT DEFAULT 0,
    match_date DATE NOT NULL,
    match_time TIME NOT NULL,
    venue VARCHAR(100) NOT NULL,
    status ENUM('upcoming', 'live', 'completed') DEFAULT 'upcoming',
    period VARCHAR(20),
    time_remaining VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (home_team_id) REFERENCES teams(id),
    FOREIGN KEY (away_team_id) REFERENCES teams(id)
);

-- Create goals table to track individual player goals in matches
CREATE TABLE goals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    team_id INT NOT NULL,
    time_scored VARCHAR(20) NOT NULL,
    period VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

-- Insert default admin
INSERT INTO admins (admin_id, password, name) VALUES ('admin', 'admin123', 'System Administrator');

-- Insert sample teams
INSERT INTO teams (name, coach, coach_phone, home_ground) VALUES
('Thunderbolts', 'John Smith', '(123) 456-7890', 'Central Arena'),
('Hurricanes', 'Maria Garcia', '(123) 456-7891', 'Hurricane Center'),
('Titans', 'David Wilson', '(123) 456-7892', 'Titan Stadium'),
('Phoenix', 'Sarah Lee', '(123) 456-7893', 'Phoenix Stadium'),
('Warriors', 'Michael Brown', '(123) 456-7894', 'Warrior Arena');
