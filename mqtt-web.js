import { FirehoseClient, PutRecordCommand } from "@aws-sdk/client-firehose";
import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import { timeStamp } from "console";
import { TextDecoder } from "util";

// Membuat instance dari klien Firehose dan S3
const firehoseClient = new FirehoseClient({ region: "us-west-2" });
const s3Client = new S3Client({ region: "us-west-2" });

// Fungsi Lambda handler
export const handler = async (event) => {
    const decoder = new TextDecoder("utf-8");

    for (const record of event.Records) {
        const payload = decoder.decode(Buffer.from(record.kinesis.data, "base64"));
        // Lakukan transformasi data di sini sesuai kebutuhan Anda
        const transformedData = transformData(JSON.parse(payload));

        // Simpan data yang telah ditransformasi ke S3
        const s3Params = {
            Bucket: 'initestingbucket01',
            Key: 'testiot/data.json',
            Body: JSON.stringify(transformedData)
        };
        await s3Client.send(new PutObjectCommand(s3Params));

        // Put record ke Firehose agar record dapat ditandai sebagai telah diproses
        const firehoseParams = {
            DeliveryStreamName: 'lks-fh',
            Record: { Data: JSON.stringify(transformedData) }
        };
        await firehoseClient.send(new PutRecordCommand(firehoseParams));
    }

    return { statusCode: 200, body: JSON.stringify('Data berhasil disimpan di S3') };
};

function transformData(data) {
    // Contoh transformasi sederhana
    const transformedData = {
        timeStamp: data.timeStamp,
        temperature: data.temperature,
        humidity: data.humidity,
        fire_intensity: data.fire_intensity,
        gas_concentration: data.gas_concentration
        // Tambahkan transformasi tambahan di sini jika diperlukan
    };
    return transformedData;
}








# just ignore

npm install @aws-sdk/client-kinesis
npm install @aws-sdk/client-firehose
npm install @aws-sdk/client-s3
pip install awsiotsdk
pip install awsaiot awscrt
