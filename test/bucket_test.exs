defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucketPid} = KV.Bucket.start_link
    {:ok, bucket: bucketPid}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", testContext do
    %{bucket: bucketPid} = testContext
    KV.Bucket.put(bucketPid, "milk", 3)
    assert KV.Bucket.get(bucketPid, "milk") == 3
    KV.Bucket.delete(bucketPid, "milk")
    assert KV.Bucket.get(bucketPid, "milk") == nil
  end
end
