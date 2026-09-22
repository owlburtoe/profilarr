INSERT INTO sonarr_quality_definitions
    (name, quality_name, min_size, max_size, preferred_size)
SELECT 'Practical', quality_name, min_size, max_size, preferred_size
FROM sonarr_quality_definitions
WHERE name = 'Sonarr'
  AND quality_name IN (
      'HDTV-1080p', 'WEBDL-1080p', 'WEBRip-1080p', 'Bluray-1080p',
      'HDTV-2160p', 'WEBDL-2160p', 'WEBRip-2160p', 'Bluray-2160p'
  );

INSERT INTO radarr_quality_definitions
    (name, quality_name, min_size, max_size, preferred_size)
SELECT 'Practical', quality_name, min_size, max_size, preferred_size
FROM radarr_quality_definitions
WHERE name = 'Radarr'
  AND quality_name IN (
      'HDTV-1080p', 'WEBDL-1080p', 'WEBRip-1080p', 'Bluray-1080p',
      'HDTV-2160p', 'WEBDL-2160p', 'WEBRip-2160p', 'Bluray-2160p'
  );
