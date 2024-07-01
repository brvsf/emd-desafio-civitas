    WITH RadarDetections AS (
        SELECT
            datahora,
            placa,
            camera_numero,
            camera_latitude,
            camera_longitude
        FROM
            `rj-cetrio.desafio.readings_2024_06`
    )

    SELECT
    rd1.placa,
    rd2.placa,
    rd1.datahora,
    rd2.datahora,
    rd1.camera_numero,
    rd2.camera_numero,
    rd1.camera_latitude,
    rd2.camera_latitude,
    rd1.camera_longitude,
    rd2.camera_longitude,
    ABS(TIMESTAMP_DIFF(rd1.datahora, rd2.datahora, SECOND)) AS diff_seconds --' calculo de tempo

    FROM
    RadarDetections rd1

    JOIN --' Join com o condicional de placas iguals, cameras diferentes, num periodo de menos de 30 minutos
    RadarDetections rd2

    ON rd1.placa = rd2.placa
    AND rd1.camera_numero <> rd2.camera_numero
    AND ABS(TIMESTAMP_DIFF(rd1.datahora, rd2.datahora, SECOND)) < 1800
    ORDER BY
    rd1.placa, rd1.datahora
