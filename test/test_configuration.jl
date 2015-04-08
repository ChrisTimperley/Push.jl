using Push

cfg_path = joinpath(dirname(@__FILE__), "configuration/mock.cfg")
cfg = Push.load_configuration(cfg_path)