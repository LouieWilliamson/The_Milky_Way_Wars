
Texture2D texture0;
SamplerState sampler0;

cbuffer CB0
{
    matrix WVPMatrix;
    float4 directional_light_vector;
    float4 directional_light_colour;
    float4 ambient_light_colour;
};

struct VOut
{
    float4 position : SV_POSITION;
    float4 color : COLOR;
    float2 texcoord : TEXCOORD;
};

VOut ModelVS(float4 position : POSITION, float2 texcoord : TEXCOORD, float3 normal : NORMAL)
{
    VOut output;
        
    output.position = mul(WVPMatrix, position);
    
    float diffuse_amount = dot(directional_light_vector, normal);
    
    diffuse_amount = saturate(diffuse_amount);
    
    output.color = ambient_light_colour + (directional_light_colour * diffuse_amount);

    
    output.texcoord = texcoord;
    
    return output;
}

float4 ModelPS(float4 position : SV_POSITION, float4 color : COLOR, float2 texcoord : TEXCOORD) : SV_TARGET
{
    return texture0.Sample(sampler0, texcoord) * color;
}