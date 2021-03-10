//
//  BaseProvider.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation
import Alamofire


public class BaseProvider {

    internal typealias successHandler<T> = (T) -> Void
    public typealias failureHandler = (CustomErrorEntity) -> Void


    internal static var session: Session = {
        let certificatesTrustEvaluator = PinnedCertificatesTrustEvaluator(certificates: Bundle(for: type(of: BaseProvider())).af.certificates, acceptSelfSignedCertificates: true, performDefaultValidation: true, validateHost: true)

        let session = Alamofire.Session(configuration: URLSessionConfiguration.af.default)
        return session
    }()


    // MARK: LIFE CYCLE
    public init() {}

    // MARK: INTERNAL
    internal func request<T>(endpoint: String, method: HTTPMethod, parameters: [String: Any]? = nil, entityType: T.Type, success: @escaping successHandler<T>, failure: @escaping failureHandler) where T: Decodable {

        if !checkReachability() {
            failure(CustomErrorEntity(code: -1, id: nil, description: nil, localizedDescription: ""))
            return
        }

        let urlEndpoint = DataConstant.host + endpoint
        let headers = HTTPHeaders(DataConstant.headers)
        let encoding: URLEncoding = (method == .post) ? .httpBody : .queryString
        let currentQueue = DispatchQueue(label: DispatchQueue.currentQueueName)
        let request = Self.session.request(urlEndpoint, method: method, parameters: parameters, encoding: encoding, headers: headers)

        request.responseJSON(queue: currentQueue, options: .allowFragments) { response in
            self.handlerResponse(response: response, entityType: entityType, success: success, failure: failure)
        }
    }

    // MARK: PRIVATE
    fileprivate func handlerResponse<T>(response: AFDataResponse<Any>, entityType: T.Type, success: successHandler<T>, failure: @escaping failureHandler) where T: Decodable {

        guard let statusCode = response.response?.statusCode,
              let responseValue = response.value as? [String: Any] else {
            failure(CustomErrorEntity(code: -1, id: nil, description: nil, localizedDescription: ""))
            return
        }

        switch statusCode {
            case 200: handlerSuccessResponse(response: responseValue, entityType: entityType, success: success, failure: failure)
            default: handlerFailureResponse(statusCode: statusCode, response: responseValue, urlString: response.request?.url?.absoluteString, failure: failure)
        }
    }

    internal func checkReachability() -> Bool {
        guard let networkManager = NetworkReachabilityManager(host: "www.google.es") else {
            return false
        }

        return networkManager.isReachable
    }
}

extension BaseProvider {

    internal func handlerSuccessResponse<T>(response: Any, entityType: T.Type, success: successHandler<T>, failure: @escaping failureHandler) where T: Decodable {
        if entityType is Bool.Type {
            success(true as! T)
            return
        }

        guard let entity = try? JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)) else {
            failure(CustomErrorEntity(code: -1, id: nil, description: nil, localizedDescription: "Parse Error"))
            return
        }

        success(entity)
    }
}


extension BaseProvider {

    internal func handlerFailureResponse(statusCode: Int, response: Any, urlString: String?, failure: @escaping failureHandler) {

        guard var entity = try? JSONDecoder().decode(CustomErrorEntity.self, from: JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)) else {
            failure(CustomErrorEntity(code: -1, id: nil, description: nil, localizedDescription: ""))
            return
        }

        entity.code = statusCode
        failure(entity)
    }
}

extension DispatchQueue {
    static var currentQueueName: String {
        return String(cString: __dispatch_queue_get_label(nil), encoding: .utf8) ?? ""
    }
}
