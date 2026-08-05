-- Anime releases should prefer English audio without making Japanese-only
-- releases ineligible. This overlay remains separate from the generated
-- upstream snapshot so scheduled refreshes preserve the local profile.

INSERT INTO regular_expressions (name, pattern, regex101_id, description) VALUES
-- The bare-DUAL branch requires a leading delimiter and a trailing hyphen so it
-- matches the ".DUAL-GROUP" tag form without catching titles that merely open
-- with the word Dual. Keeping it hyphen-anchored leaves the Latino pattern's
-- broader bare "dual" untouched.
('Anime Dual Audio - English Dub', '\b(dual[ ._-]?audio|multi[ ._-]?audio|eng(lish)?[ ._-]?dub(bed)?)\b|(?<=[ ._-])dual(?=-)|\[(en|eng)\+(ja|jpn)\]|\b(eng?|en)\+(jpn?|ja)\b', NULL, NULL),
('Anime Dual Audio Groups', '(?<=^|[\s.-])(EMBER|Judas|ZR|VARYG|Cerberus|ToonsHub|SCY|Arid|Kametsu|Reaktor|Golumpa|Yameii|Vodes|Chotab|Koten_Gars|Baws|ZeroBuild|Anime[ ._-]?Time)\b', NULL, NULL),
('Anime JP-Only Groups', '(?<=^|[\s.-])(SubsPlease|Erai-raws|HorribleSubs|Ohys-Raws|Beatrice-Raws|Moozzi2)\b', NULL, NULL),
('Anime Raw-Subbed Japanese Audio', '\b(raw|subbed|jpn?[ ._-]?audio)\b', NULL, NULL);

INSERT INTO custom_formats (name, description, include_in_rename) VALUES
('English Dub / Dual Audio', NULL, 0),
('Dual Audio Groups', NULL, 0),
('JP Audio Only', NULL, 0);

INSERT INTO custom_format_conditions
    (custom_format_name, name, type, arr_type, negate, required)
VALUES
('English Dub / Dual Audio', 'English Dub / Dual Audio', 'release_title', 'all', 0, 1),
('Dual Audio Groups', 'Dual Audio Groups', 'release_group', 'all', 0, 1),
('JP Audio Only', 'JP-Only Release Groups', 'release_group', 'all', 0, 0),
('JP Audio Only', 'Raw or Subbed in Title', 'release_title', 'all', 0, 0);

INSERT INTO condition_patterns
    (custom_format_name, condition_name, regular_expression_name)
VALUES
('English Dub / Dual Audio', 'English Dub / Dual Audio', 'Anime Dual Audio - English Dub'),
('Dual Audio Groups', 'Dual Audio Groups', 'Anime Dual Audio Groups'),
('JP Audio Only', 'JP-Only Release Groups', 'Anime JP-Only Groups'),
('JP Audio Only', 'Raw or Subbed in Title', 'Anime Raw-Subbed Japanese Audio');

INSERT INTO custom_format_tests
    (custom_format_name, title, type, should_match, description)
VALUES
('English Dub / Dual Audio', '[Metaljerk] Demon Slayer Season 1 [BD 1080p] [English Dub] [CC]', 'series', 1, 'Real Sonarr result with an explicit English-dub marker'),
('English Dub / Dual Audio', 'Demon.Slayer.Kimetsu.no.Yaiba.S05.1080p.BluRay.10-Bit.Dual-Audio.DDP2.0.x265-8RM', 'series', 1, 'Real Sonarr result with a dual-audio marker'),
('English Dub / Dual Audio', 'Kimetsu.no.Yaiba.S01.2019.1080p.BluRay.Remux.AVC.FLAC.2.0-FROGE', 'series', 0, 'Real Sonarr Japanese result without a dub marker'),
('English Dub / Dual Audio', 'Dual.Survival.S01E01.1080p.WEB-DL.DDP5.1.H.264-FROGE', 'series', 0, 'A title word must not be mistaken for a bare dual-audio tag'),
('Dual Audio Groups', 'Demon.Slayer.Kimetsu.no.Yaiba.S05.1080p.CR.WEB-DL.AAC2.0.H.264.DUAL-VARYG', 'series', 1, 'Real Sonarr result from a known dual-audio group'),
('Dual Audio Groups', 'Arid.Sky.S01E01.1080p.WEB-DL.DDP5.1.H.264-FROGE', 'series', 0, 'A short group token in the series title must not match'),
('Dual Audio Groups', 'Example.Anime.S01E01.1080p.WEB-DL.DDP5.1.H.264-SCYTHE', 'series', 0, 'A longer release-group name must not match SCY'),
('Dual Audio Groups', 'Example.Anime.S01E01.1080p.WEB-DL.DDP5.1.H.264-ZRX', 'series', 0, 'A longer release-group name must not match ZR'),
('JP Audio Only', 'Example.Anime.S01E01.1080p.WEB-DL.JPN-Audio.H.264-SubsPlease', 'series', 1, 'Japanese-audio marker and Japanese-only release group'),
('JP Audio Only', 'Example.Anime.S01E01.1080p.WEB-DL.Dual-Audio.H.264-VARYG', 'series', 0, 'Dual-audio release from a preferred group'),
('English Dub / Dual Audio', 'Demon.Slayer.Kimetsu.no.Yaiba.S05E08.The.Hashira.Unite.1080p.CR.WEB-DL.AAC2.0.H.264.DUAL-VARYG', 'series', 1, 'Real Sonarr grab: bare DUAL tag ahead of the release group'),
('English Dub / Dual Audio', 'Dual-Survival.S01E01.1080p.WEB-DL.DDP5.1.H.264-FROGE', 'series', 0, 'A hyphenated title word at the start must not match the bare DUAL branch'),
('Dual Audio Groups', 'Example.Anime.S01E01.1080p.BluRay.FLAC.x264-Kametsu', 'series', 1, 'Newly added dual-audio group'),
('Dual Audio Groups', 'Example.Anime.S01E01.1080p.WEB-DL.AAC2.0.H.264-Yameii', 'series', 1, 'Newly added dual-audio web group'),
('Dual Audio Groups', 'Anime.Timeline.S01E01.1080p.WEB-DL.H.264-FROGE', 'series', 0, 'A title beginning with Anime Time must not match the group token');

INSERT INTO quality_profiles
    (name, description, upgrades_allowed, minimum_custom_format_score,
     upgrade_until_score, upgrade_score_increment)
SELECT
    'Anime — English Preferred',
    '1080p Compact quality ladder with English-dub and dual-audio releases preferred; Japanese-only releases remain eligible.',
    -- Thresholds must match 1080p Compact's scoring magnitude: tier formats
    -- score in the 900k range, so a cutoff near the dub bonus would be met by
    -- every release and upgrades would never run. The 200000 floor still admits
    -- Japanese-only releases, which are penalised by only 5000.
    1, 200000, 10000000, 1
FROM quality_profiles
WHERE name = '1080p Compact';

INSERT INTO quality_groups (quality_profile_name, name)
SELECT 'Anime — English Preferred', name
FROM quality_groups
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_group_members
    (quality_profile_name, quality_group_name, quality_name, position)
SELECT
    'Anime — English Preferred', quality_group_name, quality_name, position
FROM quality_group_members
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_qualities
    (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
SELECT
    'Anime — English Preferred', quality_name, quality_group_name, position, enabled, upgrade_until
FROM quality_profile_qualities
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_languages (quality_profile_name, language_name, type)
SELECT 'Anime — English Preferred', language_name, type
FROM quality_profile_languages
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_tags (quality_profile_name, tag_name)
SELECT 'Anime — English Preferred', tag_name
FROM quality_profile_tags
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Anime — English Preferred', custom_format_name, arr_type, score
FROM quality_profile_custom_formats
WHERE quality_profile_name = '1080p Compact';

INSERT INTO quality_profile_custom_formats
    (quality_profile_name, custom_format_name, arr_type, score)
VALUES
('Anime — English Preferred', 'English Dub / Dual Audio', 'radarr', 15000),
('Anime — English Preferred', 'English Dub / Dual Audio', 'sonarr', 15000),
('Anime — English Preferred', 'Dual Audio Groups', 'radarr', 10000),
('Anime — English Preferred', 'Dual Audio Groups', 'sonarr', 10000),
('Anime — English Preferred', 'JP Audio Only', 'radarr', -5000),
('Anime — English Preferred', 'JP Audio Only', 'sonarr', -5000);
