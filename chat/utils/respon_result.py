


class ResponseResult(object):

    @staticmethod
    def common_args(code: int, msg: str):
        return {"code": code, "msg": msg}


    @staticmethod
    def success_no_args(code: int, msg: str):
        result_dict = ResponseResult.common_args(code, msg)
        return result_dict

    @staticmethod
    def success_has_args_same_key(code: int, msg: str, data):
        result_dict = ResponseResult.common_args(code, msg)
        result_dict.update({"data": data})
        return result_dict

    @staticmethod
    def success_has_args_diff_key(code: int, msg: str, data_key: str, data):
        result_dict = ResponseResult.common_args(code, msg)
        result_dict.update({data_key: data})
        return result_dict

    @staticmethod
    def error(code: int, msg: str):
        result_dict = ResponseResult.common_args(code, msg)
        return result_dict