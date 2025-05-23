"""Rules for compiling protos/rpcs with generated stubs."""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
    "proto_compile_toolchains",
)

py_proto_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@rules_proto_grpc_python//:python_plugin"),
                Label("//rules/proto:proto_mypy_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)

py_grpc_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@rules_proto_grpc_python//:python_plugin"),
                Label("@rules_proto_grpc_python//:grpc_python_plugin"),
                Label("//rules/proto:proto_mypy_plugin"),
                Label("//rules/proto:grpc_mypy_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = proto_compile_toolchains,
)
