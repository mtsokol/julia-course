using DataFrames
using DifferentialEquations

if length(ARGS) < 7
	print("Wrong or not enough arguments\n")
	exit(1)
end

a = parse(Int64, ARGS[1])
b = parse(Int64, ARGS[2])
c = parse(Int64, ARGS[3])
d = parse(Int64, ARGS[4])
start_u = parse(Float64, ARGS[5])
end_u = parse(Float64, ARGS[6])
file_name = ARGS[7]

function LVE(du,u,p,t)
 du[1] = a*u[1] - b*u[2]*u[1]
 du[2] = -c*u[2] + d*u[1]*u[2]
end

u0 = [start_u; end_u]
tspan = (0.0,40.0)
problem = ODEProblem(LVE,u0,tspan)
sol = solve(problem, RK4())

arr1 = []
for i = 1:length(sol.u)
    push!(arr1,sol.u[i][1])
end

arr2 = []
for i = 1:length(sol.u)
    push!(arr2,sol.u[i][2])
end

writedlm(file_name, [["t"; sol.t] ["x"; arr1] ["y"; arr2] ["experiment"; fill("exp1", length(arr1))]],';')

print("Output written to:", file_name,  "\n")
exit(0)