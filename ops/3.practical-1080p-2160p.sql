-- Prefer the requested resolution before custom-format scoring, while retaining
-- Dictionarry's release-group preferences and lower-resolution fallbacks.

INSERT INTO custom_formats (name, description, include_in_rename) VALUES
('Practical 1080p Fallback', 'Allows otherwise acceptable 1080p releases when no preferred release-group tier matches.', 0),
('Practical 2160p Fallback', 'Allows otherwise acceptable 2160p releases when no preferred release-group tier matches.', 0),
('Practical 720p Fallback', 'Allows otherwise acceptable 720p releases as a temporary fallback.', 0),
('Practical 576p Fallback', 'Allows otherwise acceptable 576p releases as a temporary fallback.', 0),
('Practical 480p Fallback', 'Allows otherwise acceptable 480p releases as a temporary fallback.', 0);

INSERT INTO custom_format_conditions
    (custom_format_name, name, type, arr_type, negate, required)
VALUES
('Practical 1080p Fallback', '1080p', 'resolution', 'all', 0, 1),
('Practical 2160p Fallback', '2160p', 'resolution', 'all', 0, 1),
('Practical 720p Fallback', '720p', 'resolution', 'all', 0, 1),
('Practical 576p Fallback', '576p', 'resolution', 'all', 0, 1),
('Practical 480p Fallback', '480p', 'resolution', 'all', 0, 1);

INSERT INTO condition_resolutions
    (custom_format_name, condition_name, resolution)
VALUES
('Practical 1080p Fallback', '1080p', '1080p'),
('Practical 2160p Fallback', '2160p', '2160p'),
('Practical 720p Fallback', '720p', '720p'),
('Practical 576p Fallback', '576p', '576p'),
('Practical 480p Fallback', '480p', '480p');

INSERT INTO custom_format_tests
    (custom_format_name, title, type, should_match, description)
VALUES
('Practical 1080p Fallback', 'The.Vampire.Diaries.S08E14.1080p.BluRay.DDP5.1.H.264-PiR8', 'series', 1, 'Generic 1080p archive release remains eligible'),
('Practical 1080p Fallback', 'The.Vampire.Diaries.S08E14.720p.BluRay.DD5.1.H.264-GROUP', 'series', 0, '720p fallback does not receive the 1080p eligibility score'),
('Practical 2160p Fallback', 'Dune.Part.Two.2024.2160p.WEB-DL.DDP5.1.H.265-GROUP', 'movie', 1, 'Generic 2160p release remains eligible'),
('Practical 2160p Fallback', 'Dune.Part.Two.2024.1080p.WEB-DL.DDP5.1.H.264-GROUP', 'movie', 0, '1080p fallback does not receive the 2160p eligibility score'),
('Practical 720p Fallback', 'Archive.Show.S01E01.720p.WEB-DL.DD5.1.H.264-GROUP', 'series', 1, 'Generic 720p release remains eligible as a fallback'),
('Practical 576p Fallback', 'Archive.Show.S01E01.576p.BluRay.DD2.0.H.264-GROUP', 'series', 1, 'Generic 576p release remains eligible as a fallback'),
('Practical 480p Fallback', 'Archive.Show.S01E01.480p.WEB-DL.DD2.0.H.264-GROUP', 'series', 1, 'Generic 480p release remains eligible as a fallback');

INSERT INTO quality_profiles
    (name, description, upgrades_allowed, minimum_custom_format_score,
     upgrade_until_score, upgrade_score_increment)
VALUES
('1080p Practical', 'Space-conscious 1080p for Sonarr and Radarr. Prefers Dictionarry Compact releases, accepts generic 1080p when needed, and keeps 720p/SD only as upgradeable fallbacks.', 1, 1, 1000000, 1),
('2160p Practical', 'Space-conscious 2160p for Sonarr and Radarr. Prefers Dictionarry Balanced releases with HDR safeguards, accepts generic 2160p when needed, and keeps 1080p/720p/SD only as upgradeable fallbacks.', 1, 1, 1000000, 1);

INSERT INTO quality_groups (quality_profile_name, name) VALUES
('1080p Practical', '1080p'),
('1080p Practical', '720p Fallback'),
('1080p Practical', 'SD Fallback'),
('2160p Practical', '2160p'),
('2160p Practical', '1080p Fallback'),
('2160p Practical', '720p Fallback'),
('2160p Practical', 'SD Fallback');

INSERT INTO quality_group_members
    (quality_profile_name, quality_group_name, quality_name, position)
VALUES
('1080p Practical', '1080p', 'Bluray-1080p', 0),
('1080p Practical', '1080p', 'WEBDL-1080p', 1),
('1080p Practical', '1080p', 'WEBRip-1080p', 2),
('1080p Practical', '1080p', 'HDTV-1080p', 3),
('1080p Practical', '720p Fallback', 'Bluray-720p', 0),
('1080p Practical', '720p Fallback', 'WEBDL-720p', 1),
('1080p Practical', '720p Fallback', 'WEBRip-720p', 2),
('1080p Practical', '720p Fallback', 'HDTV-720p', 3),
('1080p Practical', 'SD Fallback', 'Bluray-576p', 0),
('1080p Practical', 'SD Fallback', 'Bluray-480p', 1),
('1080p Practical', 'SD Fallback', 'WEBDL-480p', 2),
('1080p Practical', 'SD Fallback', 'WEBRip-480p', 3),
('1080p Practical', 'SD Fallback', 'HDTV-480p', 4),
('1080p Practical', 'SD Fallback', 'DVD', 5),
('1080p Practical', 'SD Fallback', 'SDTV', 6),
('2160p Practical', '2160p', 'Bluray-2160p', 0),
('2160p Practical', '2160p', 'WEBDL-2160p', 1),
('2160p Practical', '2160p', 'WEBRip-2160p', 2),
('2160p Practical', '2160p', 'HDTV-2160p', 3),
('2160p Practical', '1080p Fallback', 'Bluray-1080p', 0),
('2160p Practical', '1080p Fallback', 'WEBDL-1080p', 1),
('2160p Practical', '1080p Fallback', 'WEBRip-1080p', 2),
('2160p Practical', '1080p Fallback', 'HDTV-1080p', 3),
('2160p Practical', '720p Fallback', 'Bluray-720p', 0),
('2160p Practical', '720p Fallback', 'WEBDL-720p', 1),
('2160p Practical', '720p Fallback', 'WEBRip-720p', 2),
('2160p Practical', '720p Fallback', 'HDTV-720p', 3),
('2160p Practical', 'SD Fallback', 'Bluray-576p', 0),
('2160p Practical', 'SD Fallback', 'Bluray-480p', 1),
('2160p Practical', 'SD Fallback', 'WEBDL-480p', 2),
('2160p Practical', 'SD Fallback', 'WEBRip-480p', 3),
('2160p Practical', 'SD Fallback', 'HDTV-480p', 4),
('2160p Practical', 'SD Fallback', 'DVD', 5),
('2160p Practical', 'SD Fallback', 'SDTV', 6);

INSERT INTO quality_profile_qualities
    (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
VALUES
('1080p Practical', NULL, '1080p', 0, 1, 1),
('1080p Practical', NULL, '720p Fallback', 1, 1, 0),
('1080p Practical', NULL, 'SD Fallback', 2, 1, 0),
('2160p Practical', NULL, '2160p', 0, 1, 1),
('2160p Practical', NULL, '1080p Fallback', 1, 1, 0),
('2160p Practical', NULL, '720p Fallback', 2, 1, 0),
('2160p Practical', NULL, 'SD Fallback', 3, 1, 0);

INSERT INTO quality_profile_qualities
    (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
SELECT
    profile.name,
    qualities.name,
    NULL,
    ROW_NUMBER() OVER (PARTITION BY profile.name ORDER BY qualities.id)
        + CASE profile.name WHEN '1080p Practical' THEN 2 ELSE 3 END,
    0,
    0
FROM quality_profiles AS profile
CROSS JOIN qualities
WHERE profile.name IN ('1080p Practical', '2160p Practical')
  AND NOT EXISTS (
      SELECT 1
      FROM quality_group_members AS member
      WHERE member.quality_profile_name = profile.name
        AND member.quality_name = qualities.name
  );

INSERT INTO quality_profile_languages (quality_profile_name, language_name, type)
SELECT '1080p Practical', language_name, type
FROM quality_profile_languages
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_languages (quality_profile_name, language_name, type)
SELECT '2160p Practical', language_name, type
FROM quality_profile_languages
WHERE quality_profile_name = '2160p Balanced';

INSERT INTO quality_profile_tags (quality_profile_name, tag_name)
SELECT '1080p Practical', tag_name
FROM quality_profile_tags
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_tags (quality_profile_name, tag_name)
SELECT '2160p Practical', tag_name
FROM quality_profile_tags
WHERE quality_profile_name = '2160p Balanced';

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
SELECT '1080p Practical', custom_format_name, arr_type, score
FROM quality_profile_custom_formats
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
SELECT '2160p Practical', custom_format_name, arr_type, score
FROM quality_profile_custom_formats
WHERE quality_profile_name = '2160p Balanced';

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
VALUES
('1080p Practical', 'Practical 1080p Fallback', 'all', 1),
('1080p Practical', 'Practical 720p Fallback', 'all', 1),
('1080p Practical', 'Practical 576p Fallback', 'all', 1),
('1080p Practical', 'Practical 480p Fallback', 'all', 1),
('2160p Practical', 'Practical 2160p Fallback', 'all', 1),
('2160p Practical', 'Practical 1080p Fallback', 'all', 1),
('2160p Practical', 'Practical 720p Fallback', 'all', 1),
('2160p Practical', 'Practical 576p Fallback', 'all', 1),
('2160p Practical', 'Practical 480p Fallback', 'all', 1);

-- Reject micro-encodes below the practical floors and oversized encodes above
-- the space-conscious caps. Remux qualities remain untouched and disabled.
UPDATE sonarr_quality_definitions
SET min_size = 15, preferred_size = 30, max_size = 50
WHERE quality_name IN ('HDTV-1080p', 'WEBDL-1080p', 'WEBRip-1080p', 'Bluray-1080p');

UPDATE radarr_quality_definitions
SET min_size = 15, preferred_size = 30, max_size = 50
WHERE quality_name IN ('HDTV-1080p', 'WEBDL-1080p', 'WEBRip-1080p', 'Bluray-1080p');

UPDATE sonarr_quality_definitions
SET min_size = 25, preferred_size = 75, max_size = 150
WHERE quality_name IN ('HDTV-2160p', 'WEBDL-2160p', 'WEBRip-2160p', 'Bluray-2160p');

UPDATE radarr_quality_definitions
SET min_size = 25, preferred_size = 75, max_size = 150
WHERE quality_name IN ('HDTV-2160p', 'WEBDL-2160p', 'WEBRip-2160p', 'Bluray-2160p');
