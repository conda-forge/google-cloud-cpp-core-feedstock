#include <google/cloud/storage/object_metadata.h>
#include <google/cloud/version.h>
#include <iostream>
#include <sstream>
#include <string>
int main() {
    google::cloud::storage::ObjectMetadata metadata;
    metadata.set_name("native-arm64.tif").set_content_type("image/tiff");
    metadata.upsert_metadata("architecture", "arm64");
    const auto copy = metadata;
    if (copy.name() != "native-arm64.tif" || copy.content_type() != "image/tiff" ||
        !copy.has_metadata("architecture") || copy.metadata("architecture") != "arm64") return 1;
    std::ostringstream formatted;
    formatted << copy;
    if (formatted.str().find("native-arm64.tif") == std::string::npos ||
        google::cloud::version_string().empty()) return 2;
    std::cout << "Installed Google Cloud common and storage metadata consumer passed\n";
}
