-- Preserve the Latino dual-audio setup from Owl-Profilarr before that
-- database is retired. The ladder and scores mirror its portable export.

INSERT OR IGNORE INTO tags (name) VALUES
('English'),
('Spanish'),
('Latino');

INSERT INTO regular_expressions (name, pattern, regex101_id, description) VALUES
('Dual-Multi Audio', '\b(dual|multi)\b|multi\d|dual[ ._-]?audio|\b(ingl[eé]s|english|eng)\b', NULL, NULL),
('Spanish Latino', '\b(lat(ino)?|latam)\b|espa[nñ]ol[ ._-]?latino', NULL, NULL);

INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES
('Dual-Multi Audio', 'Dual Audio'),
('Dual-Multi Audio', 'English'),
('Dual-Multi Audio', 'Spanish'),
('Spanish Latino', 'Latino'),
('Spanish Latino', 'Spanish');

INSERT INTO custom_formats (name, description, include_in_rename) VALUES
('Dual Audio: English + Spanish (Latino)', NULL, 0);

INSERT INTO custom_format_conditions
    (custom_format_name, name, type, arr_type, negate, required)
VALUES
('Dual Audio: English + Spanish (Latino)', 'Dual / Multi Audio', 'release_title', 'all', 0, 1),
('Dual Audio: English + Spanish (Latino)', 'Latin American Spanish', 'release_title', 'all', 0, 1);

INSERT INTO condition_patterns
    (custom_format_name, condition_name, regular_expression_name)
VALUES
('Dual Audio: English + Spanish (Latino)', 'Dual / Multi Audio', 'Dual-Multi Audio'),
('Dual Audio: English + Spanish (Latino)', 'Latin American Spanish', 'Spanish Latino');

INSERT INTO custom_format_tests
    (custom_format_name, title, type, should_match, description)
VALUES
('Dual Audio: English + Spanish (Latino)', 'Toy.Story.1995.Remux.UHD.Bluray.Latino.English.DD.5.1.HDR.HEVC.LatTeam', 'movie', 1, 'Real Radarr result with Latino and English markers'),
('Dual Audio: English + Spanish (Latino)', 'Toy.Story.1995.1080p.BluRay.ENG.LATINO.DD5.1.H264-BEN.THE.MEN', 'movie', 1, 'Real Radarr result with abbreviated English and Latino markers'),
('Dual Audio: English + Spanish (Latino)', 'Toy.Story.1995.1080p.DSNP.WEB-DL.DDP5.1.H.264.DUAL-NoUs3r', 'movie', 0, 'Real Radarr dual-audio result without a Latino marker'),
('Dual Audio: English + Spanish (Latino)', 'Toy.Story.1995.1080p.BluRay.x264-OFT', 'movie', 0, 'Real Radarr result without language markers');

INSERT INTO quality_profiles
    (name, description, upgrades_allowed, minimum_custom_format_score,
     upgrade_until_score, upgrade_score_increment)
VALUES
('Dual Audio (ENG+Latino) - Kids', NULL, 1, 1, 0, 1);

INSERT INTO quality_groups (quality_profile_name, name) VALUES
('Dual Audio (ENG+Latino) - Kids', 'WEB 1080p'),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases'),
('Dual Audio (ENG+Latino) - Kids', 'Unwanted');

INSERT INTO quality_group_members
    (quality_profile_name, quality_group_name, quality_name, position)
VALUES
('Dual Audio (ENG+Latino) - Kids', 'WEB 1080p', 'WEBDL-1080p', 0),
('Dual Audio (ENG+Latino) - Kids', 'WEB 1080p', 'WEBRip-1080p', 1),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'REGIONAL', 0),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'DVDSCR', 1),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'TELECINE', 2),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'TELESYNC', 3),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'CAM', 4),
('Dual Audio (ENG+Latino) - Kids', 'Pre-releases', 'WORKPRINT', 5),
('Dual Audio (ENG+Latino) - Kids', 'Unwanted', 'Unknown', 0),
('Dual Audio (ENG+Latino) - Kids', 'Unwanted', 'Raw-HD', 1),
('Dual Audio (ENG+Latino) - Kids', 'Unwanted', 'BR-DISK', 2);

INSERT INTO quality_profile_qualities
    (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
VALUES
('Dual Audio (ENG+Latino) - Kids', 'Remux-2160p', NULL, 1, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'Bluray-2160p', NULL, 2, 1, 1),
('Dual Audio (ENG+Latino) - Kids', 'WEBDL-2160p', NULL, 3, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'WEBRip-2160p', NULL, 4, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'HDTV-2160p', NULL, 5, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'Remux-1080p', NULL, 6, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'Bluray-1080p', NULL, 7, 1, 0),
('Dual Audio (ENG+Latino) - Kids', NULL, 'WEB 1080p', 8, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'HDTV-1080p', NULL, 9, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'Bluray-720p', NULL, 10, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'WEBDL-720p', NULL, 11, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'WEBRip-720p', NULL, 12, 1, 0),
('Dual Audio (ENG+Latino) - Kids', 'HDTV-720p', NULL, 13, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'Bluray-576p', NULL, 14, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'Bluray-480p', NULL, 15, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'WEBDL-480p', NULL, 16, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'WEBRip-480p', NULL, 17, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'HDTV-480p', NULL, 18, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'DVD-R', NULL, 19, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'DVD', NULL, 20, 0, 0),
('Dual Audio (ENG+Latino) - Kids', 'SDTV', NULL, 21, 0, 0),
('Dual Audio (ENG+Latino) - Kids', NULL, 'Pre-releases', 22, 0, 0),
('Dual Audio (ENG+Latino) - Kids', NULL, 'Unwanted', 23, 0, 0);

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
VALUES
('Dual Audio (ENG+Latino) - Kids', 'Dual Audio: English + Spanish (Latino)', 'radarr', 100),
('Dual Audio (ENG+Latino) - Kids', 'Dual Audio: English + Spanish (Latino)', 'sonarr', 100);
