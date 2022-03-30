import Foundation
import SwiftyJSON
import SwiftCSV

public struct SpreadsheetRequest: APIRequest {
    var path: String {
        return "\(url)"
    }

    var parameters: [String : Any]? {
        return [
            "output" : "csv",
            "gid" : sheetNumber.description
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard
            let data = object as? Data,
            let string = String(data: data, encoding: .utf8)
        else {
            throw APIError.noData
        }
        do {
            let csv = try CSV(string: string)
            return csv
        } catch {
            throw APIError.noData
        }
        
    }
    private let url: String
    typealias Response = CSV
    private let sheetNumber: Int
    init(url: String, sheetNumber: Int) {
        self.url = url
        self.sheetNumber = sheetNumber
    }
    /*
    func createKeyValues(with csv: CSVReader) {
        let headers = csv.headerRow
        let langCode = "en"
        let key = "Key"
        let valueIndex = headers?.firstIndex(of: langCode) ?? .zero
        let keyIndex = headers?.firstIndex(of: key) ?? .zero
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        var generatedString = "// Autogenerated at " + formatter.string(from: Date()) + ". Do not modify\n\n"
        for row in AnyIterator(csv) {
            let key = row[keyIndex]
            let value = row[valueIndex]
            generatedString += "\"\(key)\" = \"\(value)\";\n"
        }
        writeToFile(writeText: generatedString, langCode: langCode)
    }
    */
    @discardableResult
    private func writeToFile(writeText: String,
                             langCode: String) -> Bool {

        let fileManager = FileManager.default
        let directory = URL(fileURLWithPath: "/Users/reza.dehnavi/Downloads/swift-spreadsheet-gen-master/Sources/swift-spreadsheet-gen")
        let langugePath = directory.appendingPathComponent("\(langCode).lproj")
        let filePath = langugePath.appendingPathComponent("Localizable.strings")
        do {
            if !fileManager.fileExists(atPath: langugePath.path) {
                try fileManager.createDirectory(atPath: langugePath.path,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
                print("Directory is \(langugePath.absoluteString)")
            }
            try writeText.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
            print("File generated at: \(filePath.absoluteString)")
        } catch {
            print("Error: Failed to write: \n\(error)")
            return false
        }
        return true
    }
    
}
